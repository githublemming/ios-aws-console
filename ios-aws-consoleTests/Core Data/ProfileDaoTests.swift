//
//  ProfileDaoTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 02/01/2019.
//  Copyright © 2019 Mark Haskins. All rights reserved.
//

import XCTest

@testable import ios_aws_console

class ProfileDaoTests: CoreDataBaseTest {

    var profileDao: ProfileDao!

    override func setUp() {
        super.setUp()

        profileDao = ProfileDao(container: mockPersistantContainer)
    }

    override func tearDown() {
        flushData(entityName: "Profile")
        super.tearDown()
    }

    func test_create_profile() {

        let name = "Profile Name"
        let accessId = "My Access Id"
        let secret = "My Secret"
        let active = true

        let profile = profileDao.addProfile(name: name, accessId: accessId, secret: secret, active: active)

        XCTAssertNotNil( profile )
    }

    func test_fetch_all_profiles() {

        let name = "Profile Name"
        let accessId = "My Access Id"
        let secret = "My Secret"
        let active = true

        profileDao.addProfile(name: name, accessId: accessId, secret: secret, active: active)

        let results = profileDao.getProfiles()

        XCTAssertEqual(results?.count, 1)
    }

    func test_profile_by_name() {

        let name = "Profile Name"
        let accessId = "My Access Id"
        let secret = "My Secret"
        let active = true

        profileDao.addProfile(name: name, accessId: accessId, secret: secret, active: active)

        let profile = profileDao.getProfileByName(name: "Profile Name")

        XCTAssertEqual(profile?.secret, "My Secret")
    }

    func test_active_profile() {

        profileDao.addProfile(name: "Active", accessId: "abc", secret: "def", active: true)
        profileDao.addProfile(name: "Inactive", accessId: "zyx", secret: "wvu", active: false)

        let profile = profileDao.getActiveProfile()

        XCTAssertEqual(profile?.name, "Active")
    }

    func test_set_active_profile() {

        profileDao.addProfile(name: "Active", accessId: "abc", secret: "def", active: true)
        let inactive = profileDao.addProfile(name: "Inactive", accessId: "zyx", secret: "wvu", active: false)

        profileDao.setActiveProfile(profile: inactive!)

        let profile = profileDao.getActiveProfile()

        XCTAssertEqual(profile?.name, "Inactive")
    }
}
