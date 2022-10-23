//
//  EndPoints.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 23/10/2022.
//

import Foundation

struct EndPoints {
    static let roomsURL: String = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms"
    static let peopleURL: String = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people"
    static func getRoomsDataURL() -> String {
        return roomsURL
    }
    static func getPeopleDataURL() -> String {
        return peopleURL
    }
}
