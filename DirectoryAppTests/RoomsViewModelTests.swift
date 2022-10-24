//
//  RoomsViewModelTests.swift
//  DirectoryAppTests
//
//  Created by Mindaugas Balakauskas on 24/10/2022.
//

import XCTest
@testable import DirectoryApp

final class RoomsViewModelTests: XCTestCase {

    let networkManager = FakeRoomsNetworkManager()
    var viewModel: RoomsViewModel!
    
    override func setUpWithError() throws {
        viewModel = RoomsViewModel(networkManager: NetworkManager())
    }

    override func tearDownWithError() throws {
       
    }
    func testGetPeopleAsync() async {
        var roomsCount = viewModel.roomsRecordCount
        XCTAssertEqual(0, roomsCount)
        await viewModel.getRoomsAsync()
        roomsCount = viewModel.roomsRecordCount
        XCTAssertEqual(65, roomsCount)
    }
   
}
