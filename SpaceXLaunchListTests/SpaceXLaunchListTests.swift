//
//  SpaceXLaunchListTests.swift
//  SpaceXLaunchListTests
//
//  Created by Geraldine on 06/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import XCTest
@testable import SpaceXLaunchList

class SpaceXLaunchListTests: XCTestCase {
    
    var view: LaunchListViewMock!
    var service: LaunchDataServiceMock!
    var presenter: LaunchListPresenter!
    
    override func setUp() {
        service   = LaunchDataServiceMock()
        view = LaunchListViewMock()
        presenter = LaunchListPresenter(view: view, launchDataService: service)
    }
    
    func testGetLaunchData() {
        XCTAssertTrue(presenter.launchData.isEmpty, "List of launch should be empty before the request")
        presenter.getLaunchData()
        XCTAssertFalse(presenter.launchData.isEmpty, "List of launch should not be empty after the request")
        XCTAssertEqual(presenter.launchData.count, 3, "All element should be 3")
    }
    
    func testSortByEmergency() {
        presenter.getLaunchData()
        presenter.sortByYear()
        let firstObjectDate = presenter.launchData.first?.launchYear
        let lastObjectDate = presenter.launchData.last?.launchYear
        XCTAssertEqual(firstObjectDate, "2021", "The most recent date should be equal to 2021")
        XCTAssertEqual(lastObjectDate, "2018", "The oldest date should be equal to 2018")
    }
    
}

// MARK: - LaunchDataServiceMock
class LaunchDataServiceMock: APICLient {
    
    private let launchData: [LaunchData] = [
        LaunchData(missionName: "Mission Test 1", launchYear: "2020", links: Links(videoLink: "", imageLink: "")),
        LaunchData(missionName: "Mission Test 2", launchYear: "2018", links: Links(videoLink: "", imageLink: "")),
        LaunchData(missionName: "Mission Test 3", launchYear: "2021", links: Links(videoLink: "", imageLink: ""))
    ]
    
    override func getLaunchData() {
        delegate?.didReceiveLaunchData(launchData)
    }
    
}

// MARK: - LaunchListViewMock
class LaunchListViewMock: LaunchListViewDelegate {
    func setLaunchData() {}
    
    func showError(title: String, message: String) {}
}
