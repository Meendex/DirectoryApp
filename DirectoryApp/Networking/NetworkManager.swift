//
//  NetworkManager.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import Foundation

protocol NetworkManagerActions {
    func getData(from url: String) async throws -> Data
    func getData(from url: URL) async throws -> Data
    func parseJsonData<T: Decodable>(_ type: T.Type, data: Data) throws -> T
}

final class NetworkManager: NetworkManagerActions {
    
    func getData(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        do {
            let data = try await getData(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    func getData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw NetworkError.dataNotFound
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
