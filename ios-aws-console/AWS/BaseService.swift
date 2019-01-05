//
//  BaseService.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import Alamofire

/// Abstract class that all services should implement
class BaseService {

    let swawsh = SwawshCredential.sharedInstance

    let ec2Dao: Ec2Dao!
    let regionDao: RegionDao!
    let profileDao: ProfileDao!

    /**
     Default constructor

     - Parameters:
       - ec2_dao: an instance of Ec2Dao
       - region_dao: an instance of RegionDao
       - profile_dao: an instance of ProfileDao
    */
    init(ec2Dao: Ec2Dao, regionDao: RegionDao, profileDao: ProfileDao) {
        self.ec2Dao = ec2Dao
        self.regionDao = regionDao
        self.profileDao = profileDao
    }

    /**
     Makes an API call to AWS

     - Parameters:
       - awsService: The AWS Service to send the request to e.g. EC2
       - region: The region the request should target
       - queryParams: The actual request e.g. DescribeInstances
       - completion: A completion handler to asynchronoulst handle any response
    */
    func sendRequest(awsService: AwsService,
                     region: String,
                     queryParams: String,
                     completion: @escaping (Data) -> Void) {

        if let activeProfile = profileDao.getActiveProfile() {

            let swawsh = SwawshCredential.sharedInstance
            let authorization = swawsh.generateCredential(
                method: .GET,
                path: "/",
                endPoint: awsService.endpoint(),
                queryParameters: "Action=\(queryParams)&Version=2013-10-15",
                payloadDigest: SwawshCredential.emptyStringHash,
                region: region,
                service: awsService.service(),
                accessKeyId: activeProfile.access_id!,
                secretKey: activeProfile.secret!
            )

            let headers: HTTPHeaders = [
                "Authorization": authorization!,
                "x-amz-date": swawsh.getDate(),
                "x-amz-content-sha256": SwawshCredential.emptyStringHash,
                "Host": awsService.endpoint()
            ]

            let endpoint = awsService.endpointWithRegion(region: region)
            let url = "https://\(endpoint)?Action=\(queryParams)&Version=2013-10-15"
            Alamofire.request(url, headers: headers).responseData { response in

                if let data = response.data {
                     completion(data)
                }
            }
        }
    }
}
