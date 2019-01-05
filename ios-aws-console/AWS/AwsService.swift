//
//  AwsService.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

// All Service should implment this protocol
protocol AwsService: class {

    /**
     Returns the AWS Servce

     - returns: a String e.g EC2
     */
    func service() -> String

    /**
     Returns the AWS Service Endpoint

     - returns: A String e.g. ec2.amazonaws.com
     */
    func endpoint() -> String

    /**
     Returns the AWS Service Endpoint with region

     - returns: A String e.g ec2.eu-west-1.amazonaws.com
     */
    func endpointWithRegion(region: String) -> String
}
