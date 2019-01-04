//
//  Ec2Dao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

class Ec2Dao: BaseDao {

    @discardableResult func addInstance(instanceId: String, region: String, details: String) -> EC2? {

        guard let ec2 = NSEntityDescription.insertNewObject(
            forEntityName: "EC2", into: persistentContainer.viewContext) as? EC2 else { return nil }

        ec2.instanceId = instanceId
        ec2.region = region
        ec2.detail = details

        save()

        return ec2
    }

    func updateInstance(instanceId: String, region: String, details: String) {

        let ec2 = getInstanceByInstanceId(instanceId: instanceId)
        ec2?.region = region
        ec2?.detail = details

        save()
    }

    func getInstances() -> [EC2]? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        let instances = try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]

        return instances
    }

    func getInstancesByRegion(region: String) -> [EC2]? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        ec2Request.predicate = NSPredicate(format: "region == %@", region)

        return try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]
    }

    func getInstanceByInstanceId(instanceId: String) -> EC2? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        ec2Request.predicate = NSPredicate(format: "instanceId == %@", instanceId)

        let result = try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]
        if (result?.count)! > 0 {
            return result?[0]
        } else {
            return nil
        }
    }
}
