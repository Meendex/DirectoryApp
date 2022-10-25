//
//  NetworkManager.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import Foundation

protocol NetworkManagerActions {
    func getData(from url: URL) async throws -> Data
}

final class NetworkManager: NetworkManagerActions {
    func getData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}
