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

    func test_get_instances() {

        ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-west-1", details: "data")

        let results = ec2Dao.getInstances()
        XCTAssertEqual(results?.count, 1)
    }

    func test_get_instances_by_region() {

        ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-west-1", details: "data")
        ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-central-1", details: "data")

        let results = ec2Dao.getInstancesByRegion(region: "eu-west-1")
        XCTAssertEqual(results?.count, 1)
    }

    func test_add_instance() {

        let ec2 = ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-west-1", details: "data")
        XCTAssertNotNil( ec2 )
    }

    func test_get_instance_by_instanceid_pass() {

        ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-west-1", details: "data")

        let ec2 = ec2Dao.getInstanceByInstanceId(instanceId: "i-123456789")
        XCTAssertEqual(ec2?.instanceId, "i-123456789")
    }

    func test_get_instance_by_instanceid_fail() {

        let ec2 = ec2Dao.getInstanceByInstanceId(instanceId: "i-123456789")
        XCTAssertNil( ec2 )
    }

    func test_update_instance() {

        ec2Dao.addInstance(instanceId: "i-123456789", region: "eu-west-1", details: "data")
        let ec2 = ec2Dao.getInstanceByInstanceId(instanceId: "i-123456789")
        XCTAssertEqual(ec2?.region, "eu-west-1")

        ec2Dao.updateInstance(instanceId: "i-123456789", region: "eu-central-1", details: "data")
        let ec22 = ec2Dao.getInstanceByInstanceId(instanceId: "i-123456789")
        XCTAssertEqual(ec22?.region, "eu-central-1")
    }
}
