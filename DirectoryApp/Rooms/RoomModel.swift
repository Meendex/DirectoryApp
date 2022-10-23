//
//  RoomModel.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import Foundation

struct RoomResponse: Decodable {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}
