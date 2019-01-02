//
//  ios_aws_consoleTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import XCTest
@testable import ios_aws_console

class Ec2DaoTests: CoreDataBaseTest {

    var ec2Dao: Ec2Dao?

    override func setUp() {
        super.setUp()

        ec2Dao = Ec2Dao(container: mockPersistantContainer)
    }

    override func tearDown() {
        flushData(entityName: "EC2")
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
