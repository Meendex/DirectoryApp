//
//  RoomsViewModel.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import Foundation
import Combine

protocol RoomsViewModelIn {
    func getRoomsAsync() async
    //func getRoomsClosure()
}
protocol RoomsViewModelOut {
    var roomsRecordCount: Int {get}
    func getRoomsModel(index: Int) -> RoomResponse
}

final class RoomsViewModel: JsonParser {
    
    @Published var rooms: [RoomResponse] = []
    private let networkManager: NetworkManagerActions
    
    init(networkManager: NetworkManagerActions = NetworkManager()) {
        self.networkManager = networkManager
    }
}
extension RoomsViewModel: RoomsViewModelIn {
    func getRoomsAsync() async {
        
        guard let url = URL(string: EndPoints.roomsURL) else {
            print("Invalid URl")
            // Handle error
            return
        }
        do {
            let data = try await
            networkManager.getData(from:url)
            rooms = try
           parseJsonData([RoomResponse].self, data: data)
        } catch {
            print(error)
            rooms = []
            // Handle error
        }
    }
}
extension RoomsViewModel: RoomsViewModelOut {
    var roomsRecordCount: Int { return rooms.count}
    func getRoomsModel(index: Int) -> RoomResponse {
        return rooms[index]
    }
}
