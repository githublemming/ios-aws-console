//
//  Ec2Service.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

import SWXMLHash

/// Provides EC2 service implementation
class Ec2Service: BaseService, AwsService {

    override init(ec2Dao: Ec2Dao, regionDao: RegionDao, profileDao: ProfileDao) {
        super.init(ec2Dao: ec2Dao, regionDao: regionDao, profileDao: profileDao)
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

    /**
     Makes a 'DescribeInstances' request to AWS

     - Parameters:
       - region: The AWS region to make the request against
    */
    func describeInstances(region: String) {

        sendRequest(awsService: self,
                    region: region,
                    queryParams: "DescribeInstances",
                    completion: describeInstancesCompletionHandler)
    }
    /**
     Handles the response to the DescribeInstances request

     - Parameters:
       - instances: Data object with instances information
    */
    func describeInstancesCompletionHandler(instances: Data) {

        let xml = SWXMLHash.parse(instances)
        let instancesXml = xml["DescribeInstancesResponse"]["reservationSet"]["item"]["instancesSet"]

        for item in instancesXml.children {

            let instanceId = item["instanceId"].element!.text
            let availabilitZone = item["placement"]["availabilityZone"].element!.text
            let detail = Ec2XmltoJson().getJsonString(xml: item)

            if ec2Dao.getInstanceByInstanceId(instanceId: instanceId) != nil {

                ec2Dao.updateInstance(
                    instanceId: instanceId,
                    region: String(availabilitZone.dropLast()),
                    details: detail)
            } else {
                
                ec2Dao.addInstance(
                    instanceId: instanceId,
                    region: String(availabilitZone.dropLast()),
                    details: detail)
            }
        }

        NotificationCenter.default.post(name: .instancesUpdated, object: self, userInfo: nil)
    }

    /**
     Makes a 'DescribeRegions' request to AWS
     */
    func describeRegions() {

        sendRequest(awsService: self,
                    region: "eu-west-1",
                    queryParams: "DescribeRegions",
                    completion: describeRegionsCompletionHandler)
    }
    /**
     Handles the response to the DescribeRegions request

     - Parameters:
       - instances: Data object with regions information
     */
    func describeRegionsCompletionHandler(regions: Data) {

        let xml = SWXMLHash.parse(regions)
        let regionXml = xml["DescribeRegionsResponse"]["regionInfo"]
        for item in regionXml.children {

            let regionName = item["regionName"].element!.text

            let region = regionDao.getRegionByName(name: regionName)
            if region == nil {
                regionDao.addRegion(name: regionName, active: false)
            }
        }

        NotificationCenter.default.post(name: .regionsUpdated, object: self, userInfo: nil)
    }
}
