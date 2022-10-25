//
//  PeopleViewModel.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 23/10/2022.
//

import Foundation
import Combine

protocol PeopleViewModelIn {
    func getPeopleAsync() async
}

protocol PeopleViewModelOut {
    var peopleRecordCount: Int {get}
    func getPeopleModel(index: Int) -> PeopleDetails
    func getPeopleImage(for index: Int, completion:@escaping(Data)-> Void)
}

struct PeopleDetails {
    let joinedAt: String
    let fullName: String
    let avatar: String
    let email: String
    let favouriteColor: String
    let jobTitle: String
}

final class PeopleViewModel: JsonParser {
    private var images: [String: Data] = [:]
    private var imagesDownloadInProgress: [Int: Bool] = [:]
    private let networkManager: NetworkManagerActions
    private var dateFormatter = DateFormatter()
    @Published var peopleDetails: [PeopleDetails] = []
    private var peopleRespose: PeopleRespose?

    init(networkManager: NetworkManagerActions = NetworkManager()) {
        self.networkManager = networkManager
    }
}
extension PeopleViewModel: PeopleViewModelIn {
    func getPeopleAsync() async {
        do {
            guard let url = URL(string: EndPoints.peopleURL) else {
                print("Invalid URl")
                // Handle error
                return
            }
            let data = try await
            networkManager.getData(from:url)
            let peopleList = try
            parseJsonData([PeopleRespose].self, data: data)

            peopleDetails =  peopleList.map { peopleReponse in
                peopleReponse.toPeopleDetails(dateFormatter: dateFormatter)
            }
                        
            } catch {
            print(error)
                peopleDetails = []
        }
    }
}
extension PeopleViewModel: PeopleViewModelOut {
    var peopleRecordCount: Int {
        return peopleDetails.count
    }
    
    func getPeopleModel(index: Int) -> PeopleDetails {
        return peopleDetails[index]
    }
    
    func getPeopleImage(for index: Int, completion:@escaping(Data)-> Void) {
        let people = getPeopleModel(index: index)
        let urlString = people.avatar
        guard urlString.starts(with: "https"), let url = URL(string: urlString) else {
            return
        }
        if let imageData = images[url.absoluteString] {
            completion(imageData)
        }
        
        guard imagesDownloadInProgress[index] == nil else { return  }
      
        imagesDownloadInProgress[index] = true
     
        Task {
            do {
               let  imageData = try await networkManager.getData(from: url)
                images[url.absoluteString] = imageData
                imagesDownloadInProgress.removeValue(forKey: index)
                completion(imageData)
            } catch {
                print(error)
            }
        }
     
    }
}

extension String {
    func formatDate(_ dateFormatter: DateFormatter, inputFormate: String, outputFormate: String) -> String {
        dateFormatter.dateFormat = inputFormate
        guard let date = dateFormatter.date(from: self) else { return ""}
        
        dateFormatter.dateFormat = outputFormate

        let outputDateStr = dateFormatter.string(from: date)
        return outputDateStr
    }
}


// move formatDate to seperate string extensin file
// Move inputDateFormate and outputDateFormate in constate files

// all coded string should be in constant file



