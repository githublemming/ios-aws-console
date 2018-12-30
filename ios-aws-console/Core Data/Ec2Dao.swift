//
//  Ec2Dao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

class Ec2Dao: BaseDao {

    let ec2Service = Ec2Service()

    func getInstances(region: String) -> [EC2]? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        let instances = try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]

        return instances
    }
}
