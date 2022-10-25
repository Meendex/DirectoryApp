//
//  JsonParser.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 25/10/22.
//

import Foundation

protocol JsonParser {
    func parseJsonData<T: Decodable>(_ type: T.Type, data: Data) throws -> T
}

extension JsonParser {
    func parseJsonData<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        do {
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            return parsedData
        } catch {
            throw NetworkError.parsingFailed
        }
    }
}
