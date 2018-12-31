//
//  BaseService.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import Alamofire
import SwiftyXMLParser

class BaseService {

    let swawsh = SwawshCredential.sharedInstance
    let profileDao = ProfileDao()

    func sendRequest(awsService: AwsService,
                     region: String,
                     queryParams: String,
                     completion: @escaping (XML.Accessor) -> Void) {

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

            let url = "https://\(awsService.endpointWithRegion(region: region))?Action=\(queryParams)&Version=2013-10-15"
            Alamofire.request(url, headers: headers).responseData { response in

                if let data = response.data {
                    completion(XML.parse(data))
                }
            }
        }
    }
}
