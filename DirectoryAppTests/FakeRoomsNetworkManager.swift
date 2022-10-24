//
//  FakeRoomsNetworkManager.swift
//  DirectoryAppTests
//
//  Created by Mindaugas Balakauskas on 24/10/2022.
//

import Foundation

@testable import DirectoryApp

class FakeRoomsNetworkManager: NetworkManagerActions {
    
    func getData(from url: String) async throws -> Data {
        if let url = Bundle.main.url(forResource: "rooms", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                throw NetworkError.dataNotFound
            }
            
        } else {
            throw NetworkError.invalidURL
        }
    }
    func getData(from url: URL) async throws -> Data {
        if let url = Bundle.main.url(forResource: "rooms", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                throw NetworkError.dataNotFound
            }
        } else {
            throw  NetworkError.invalidURL
        }
    }
    func parseJsonData<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        do {
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            return parsedData
        } catch {
            throw NetworkError.parsingFailed
        }
    }
}
