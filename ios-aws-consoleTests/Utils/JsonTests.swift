//
//  JsonTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 05/01/2019.
//  Copyright © 2019 Mark Haskins. All rights reserved.
//

import XCTest

import SwiftyJSON

@testable import ios_aws_console

class JsonTests: XCTestCase {

    // storing dictionaries in Array as an array is easier to handle as a Table DataSource
    var details = [[String: String]]()

    override func setUp() {
        super.setUp()
        details = [[String: String]]()
    }

    func test_json() {

        details.append(["Key 1":"Value 1"])
        details.append(["Key 2":"Value 2"])

        let json = JSON(details)
        let jsonJtring = json.rawString(options: [])!

        let newJson = JSON(jsonJtring.data(using: .utf8, allowLossyConversion: false)!)
        for (_, subJson):(String, JSON) in newJson {
            let detail = subJson.dictionaryObject
            for (property, value) in detail! {
                print("\(property): \(value)")
            }
        }
    }
}
