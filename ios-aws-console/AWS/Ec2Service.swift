//
//  Ec2Service.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import SwiftyXMLParser

class Ec2Service: BaseService, AwsService {

    let ec2Dao = Ec2Dao()
    let regionDao = RegionDao()

    func service() -> String {
        return "ec2"
    }

    func endpoint() -> String {
        return "ec2.amazonaws.com"
    }

    func endpointWithRegion(region: String) -> String {
        return "ec2.\(region).amazonaws.com"
    }

    func describeInstances(region: String) {
        sendRequest(awsService: self, region:region, queryParams: "DescribeInstances", completion: describeInstancesCompletionHandler)
    }
    func describeInstancesCompletionHandler(instances: XML.Accessor) {

        for instance in instances["DescribeInstancesResponse", "reservationSet", "item", "instancesSet", "item"] {

            let az = instance["placement", "availabilityZone"].text!
            let instanceId = instance["instanceId"].text!

            // if instance id already exists get existing model and overwrite, else create a new one
            ec2Dao.getInstanceByInstanceId(instanceId: instanceId)

            let ec2 = EC2()
            ec2.id = instanceId
            ec2.region = String(az.dropLast())
            ec2.xml = instance.text!
        }

        // save

        NotificationCenter.default.post(name: .instancesUpdated, object: self, userInfo: nil)
    }

    func describeRegions() {
        sendRequest(awsService: self, region:"eu-west-1", queryParams: "DescribeRegions", completion: describeRegionsCompletionHandler)
    }
    func describeRegionsCompletionHandler(regions: XML.Accessor) {

        for region in regions["DescribeRegionsResponse ", "regionInfo", "item"] {

            let regionName = region["regionName"].text!
            if !regionDao.regionExists(region: regionName) {
                let region = Region()
                region.name = regionName
            }
        }

        // save

        NotificationCenter.default.post(name: .regionsUpdated, object: self, userInfo: nil)
    }
}
