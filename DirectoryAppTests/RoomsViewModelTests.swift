//
//  RoomsViewModelTests.swift
//  DirectoryAppTests
//
//  Created by Mindaugas Balakauskas on 24/10/2022.
//

import XCTest
@testable import DirectoryApp

final class RoomsViewModelTests: XCTestCase {

    let networkManager = FakeNetworkManager()
    var viewModel: RoomsViewModel!
    
    override func setUpWithError() throws {
        viewModel = RoomsViewModel(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
       
    }
    
    func testGetPeopleAsyncFailure() async {
        var roomsCount = viewModel.roomsRecordCount
        XCTAssertEqual(0, roomsCount)
        networkManager.mockUrl = "test"
        await viewModel.getRoomsAsync()
        roomsCount = viewModel.roomsRecordCount
        XCTAssertEqual(0, roomsCount)
    }
    
    func testGetPeopleAsyncSuccess() async {
        var roomsCount = viewModel.roomsRecordCount
        XCTAssertEqual(0, roomsCount)
        networkManager.mockUrl = "rooms"
        await viewModel.getRoomsAsync()
        roomsCount = viewModel.roomsRecordCount
        XCTAssertEqual(65, roomsCount)
    }
       
}
