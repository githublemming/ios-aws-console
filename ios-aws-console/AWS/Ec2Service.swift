//
//  Ec2Service.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import SwiftyXMLParser

class Ec2Service: BaseService, AwsService {

    func describeInstances(region: String) {

        sendRequest(awsService: self,
                    region:region,
                    queryParams: "DescribeRegions",
                    completion: describeInstancesCompletion)
    }

    func describeInstancesCompletion(instances: XML.Accessor) {
        for instance in instances["DescribeInstancesResponse", "reservationSet", "item", "instancesSet", "item"] {
            
            print(instance["instanceId"].text!)

            // store instance (item) in Core Data keyed by instance id
        }
    }

    func service() -> String {
        return "ec2"
    }
    func endpoint() -> String {
        return "ec2.amazonaws.com"
    }

    func endpointWithRegion(region: String) -> String {
        return "ec2.\(region).amazonaws.com"
    }
}
