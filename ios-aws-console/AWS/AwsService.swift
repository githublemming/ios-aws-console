//
//  AwsService.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

protocol AwsService: class {

    func service() -> String
    func endpoint() -> String
    func endpointWithRegion(region: String) -> String
}
