//
//  DirectoryAppTests.swift
//  DirectoryAppTests
//
//  Created by Mindaugas Balakauskas on 20/10/2022.
//

import XCTest
@testable import DirectoryApp

final class PeopleViewModelTests: XCTestCase {

    let networkManager = FakePeopleNetworkManager()
    var viewModel: PeopleViewModel!
    
    override func setUpWithError() throws {
        viewModel = PeopleViewModel(networkManager: NetworkManager())
    }

    override func tearDownWithError() throws {
       
    }
    func testGetPeopleAsync() async {
        var peopleCount = viewModel.peopleRecordCount
        XCTAssertEqual(0, peopleCount)
        await viewModel.getPeopleAsync()
        peopleCount = viewModel.peopleRecordCount
        XCTAssertEqual(70, peopleCount)
    }
   
}
