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

    var ec2Dao: Ec2Dao!

    override func setUp() {
        super.setUp()
        ec2Dao = Ec2Dao(container: mockPersistantContainer)
    }

    override func tearDown() {
        flushData(entityName: "EC2")
        super.tearDown()
    }

//    func test_add_instance() {
//
//        let ec2 = ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-west-1", detail: "data")
//        XCTAssertNotNil( ec2 )
//    }
}
