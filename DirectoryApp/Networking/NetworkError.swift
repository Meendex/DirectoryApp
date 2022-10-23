//
//  NetworkError.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 23/10/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case dataNotFound
    case parsingFailed
}
