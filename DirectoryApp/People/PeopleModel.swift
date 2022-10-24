//
//  PeopleModel.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 23/10/2022.
//

import Foundation

struct PeopleRespose: Decodable {
    let createdAt, firstName: String
    let avatar: String
    let lastName, email, jobtitle, favouriteColor: String
    let id: String
    let data: DataClass?
    let to, fromName: String?
}
struct DataClass: Decodable {
    let title, body, id, toID: String
    let fromID, meetingid: String

    enum CodingKeys: String, CodingKey {
        case title, body, id
        case toID = "toId"
        case fromID = "fromId"
        case meetingid
    }
}
