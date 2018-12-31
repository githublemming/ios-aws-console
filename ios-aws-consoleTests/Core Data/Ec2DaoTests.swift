//
//  ios_aws_consoleTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import XCTest
@testable import ios_aws_console

class Ec2Dao: CoreDataBaseTest {

    var ec2Dao: Ec2Dao?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        ec2Dao = Ec2Dao(persistentTestContainer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
