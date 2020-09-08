//
//  BaseTests.swift
//  SpaceXLaunchListTests
//
//  Created by Geraldine on 08/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import XCTest
@testable import SpaceXLaunchList

class BaseTests: XCTestCase {

        let config = Configuration()
        
        override func setUp() {}

          func test_API_url_IsCorrect() {
             let apiURL = config.apiURL
             let expectedApiURL = "https://api.spacexdata.com/v2/launches"
             XCTAssertEqual(apiURL, expectedApiURL, "URL does not match expected URL. Expected URLs to match.")
         }

}
