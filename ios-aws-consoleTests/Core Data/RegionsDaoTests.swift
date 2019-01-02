//
//  RegionsDaoTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 02/01/2019.
//  Copyright © 2019 Mark Haskins. All rights reserved.
//

import XCTest
@testable import ios_aws_console

class RegionDaoTests: CoreDataBaseTest {

    var regionDao: RegionDao?

    override func setUp() {
        super.setUp()

        regionDao = RegionDao(container: mockPersistantContainer)
    }

    override func tearDown() {
        flushData(entityName: "Region")
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
