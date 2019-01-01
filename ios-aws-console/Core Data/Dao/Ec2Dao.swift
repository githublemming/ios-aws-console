//
//  Ec2Dao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

class Ec2Dao: BaseDao {

    func getInstances(region: String) -> [EC2]? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        ec2Request.predicate = NSPredicate(format: "region == %i", region)

        return try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]
    }

    func getInstanceByInstanceId(instanceId: String) -> EC2? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        ec2Request.predicate = NSPredicate(format: "instanceId == %i", instanceId)

        let result = try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]
        return result?[0]
    }
}
