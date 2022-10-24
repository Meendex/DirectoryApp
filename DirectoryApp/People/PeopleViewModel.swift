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
    func getPeopleModel(index: Int) -> PeopleRespose
    func getPeopleImage(for index: Int) async -> Data?
}
final class PeopleViewModel {
    @Published var peopleList: [PeopleRespose] = []
    private var images: [String: Data] = [:]
    private var imagesDownloadInProgress: [Int: Bool] = [:]
    private let networkManager: NetworkManagerActions
    
    init(networkManager: NetworkManagerActions) {
        self.networkManager = networkManager
    }
}
extension PeopleViewModel: PeopleViewModelIn {
    func getPeopleAsync() async {
        do {
            let data = try await
            networkManager.getData(from: EndPoints.peopleURL)
            _ = try
            networkManager.parseJsonData(PeopleRespose.self, data: data)
        } catch {
            print(error)
        }
    }
}
extension PeopleViewModel: PeopleViewModelOut {
    var peopleRecordCount: Int {
        return peopleList.count
    }
    
    func getPeopleModel(index: Int) -> PeopleRespose {
        return peopleList[index]
    }
    
    func getPeopleImage(for index: Int) async -> Data? {
        let people = getPeopleModel(index: index)
        let urlString = people.avatar
        guard urlString.starts(with: "https"), let url = URL(string: urlString) else {
            return nil
        }
        if let imageData = images[url.absoluteString] {
            return imageData
        }
        if imagesDownloadInProgress[index] != nil {
            return nil
        }
        var data = Data()
        imagesDownloadInProgress[index] = true
        do {
            data = try await networkManager.getData(from: url)
        } catch {
            print(error)
        }
        images[url.absoluteString] = data
        imagesDownloadInProgress.removeValue(forKey: index)
        return data
    }
}
