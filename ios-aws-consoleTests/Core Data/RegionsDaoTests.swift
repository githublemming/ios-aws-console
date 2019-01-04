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

    var regionDao: RegionDao!

    override func setUp() {
        super.setUp()

        regionDao = RegionDao(container: mockPersistantContainer)
    }

    override func tearDown() {
        flushData(entityName: "Region")
        super.tearDown()
    }

    func test_create_region() {

        let name = "eu-west-1"
        let active = true

        let region = regionDao.addRegion(name: name, active: active)

        XCTAssertNotNil( region )
    }

    func test_fetch_all_regions() {

        regionDao.addRegion(name: "eu-west-1", active: true)

        let results = regionDao.getRegions()

        XCTAssertEqual(results?.count, 1)
    }

    func test_region_by_name() {

        regionDao.addRegion(name: "eu-west-1", active: true)

        let result = regionDao.getRegionByName(name: "eu-west-1")

        XCTAssertEqual(result?.name, "eu-west-1")
    }

    func test_active_region() {

        regionDao.addRegion(name: "eu-west-1", active: true)
        regionDao.addRegion(name: "eu-west-2", active: false)

        let region = regionDao.getActiveRegion()

        XCTAssertEqual(region?.name, "eu-west-1")
    }

    func test_set_active_region() {

        regionDao.addRegion(name: "eu-west-1", active: true)
        let inactive = regionDao.addRegion(name: "eu-west-2", active: false)

        regionDao.setActiveRegion(region: inactive!)

        let region = regionDao.getActiveRegion()

        XCTAssertEqual(region?.name, "eu-west-2")
    }

}
