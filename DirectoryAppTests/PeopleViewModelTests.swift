//
//  DirectoryAppTests.swift
//  DirectoryAppTests
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import XCTest
@testable import DirectoryApp

final class PeopleViewModelTests: XCTestCase {

    let networkManager = FakeNetworkManager()
    var viewModel: PeopleViewModel!
    
    override func setUpWithError() throws {
        viewModel = PeopleViewModel(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
       
    }
    
    func testGetPeopleAsyncFailure() async {
        var peopleCount = viewModel.peopleRecordCount
        XCTAssertEqual(0, peopleCount)
        networkManager.mockUrl = "test"
        await viewModel.getPeopleAsync()
        peopleCount = viewModel.peopleRecordCount
        XCTAssertEqual(0, peopleCount)
    }
    func testGetPeopleAsyncSuccess() async {
        var peopleCount = viewModel.peopleRecordCount
        XCTAssertEqual(0, peopleCount)
        networkManager.mockUrl = "people"
        await viewModel.getPeopleAsync()
        peopleCount = viewModel.peopleRecordCount
        XCTAssertEqual(71, peopleCount)
    }
    
   
   
}
