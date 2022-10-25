//
//  FakePeopleNetworkManager.swift
//  DirectoryAppTests
//
//  Created by Mindaugas Balakauskas on 24/10/2022.
//

import Foundation
@testable import DirectoryApp

class FakeNetworkManager: NetworkManagerActions {
    
    var mockUrl: String = ""
    func getData(from url: URL) async throws -> Data {
        if let url = Bundle.main.url(forResource: mockUrl, withExtension: "json") {
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
}
