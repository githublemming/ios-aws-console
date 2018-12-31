//
//  Ec2ServiceTests.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import XCTest
import SwiftyXMLParser

@testable import ios_aws_console

class Ec2ServiceTests: XCTestCase {

    let ec2Service = Ec2Service()

    func testDescribeInstances() {
        ec2Service.describeInstances(region: "eu-west-1", completion: describeInstancesResponse)
    }
    func describeInstancesResponse(instances: XML.Accessor) {

    }

    func testDescribeRegions() {
        ec2Service.describeInstances(completion: describeRegionsResponse)
    }
    func describeRegionsResponse(regions: XML.Accessor) {

        for region in regions["DescribeRegionsResponse ", "regionInfo", "item"] {
            print(region["regionName"].text!)
        }
    }
}
