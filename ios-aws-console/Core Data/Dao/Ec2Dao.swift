//
//  Ec2Dao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

/// DAP class that handles EC2 objects in Core Data
class Ec2Dao: BaseDao {

    /**
     Creates a new EC2 object

     - Parameters:
       - instanceId : Unique Id of the instance
       - region; Region instance was located in
       - details: JSON string containing all information about the instance

     - Returns:
       An EC2 object or nil of the creation failed
    */
    @discardableResult func addInstance(instanceId: String, region: String, details: String) -> EC2? {

        guard let ec2 = NSEntityDescription.insertNewObject(
            forEntityName: "EC2", into: persistentContainer.viewContext) as? EC2 else { return nil }

        ec2.instanceId = instanceId
        ec2.region = region
        ec2.detail = details

        save()

        return ec2
    }

    /**
     Updates the EC2

     - Parameters:
       - instanceId : Unique Id of the instance
       - region; Region instance was located in
       - details: JSON string containing all information about the instance
    */
    func updateInstance(instanceId: String, region: String, details: String) {

        let ec2 = getInstanceByInstanceId(instanceId: instanceId)
        ec2?.region = region
        ec2?.detail = details

        save()
    }

    /**
     Returns all EC2s

     - Returns:
       An array of EC2s
    */
    func getInstances() -> [EC2]? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        let instances = try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]

        return instances
    }

    /**
     Returns all EC2s for a region

     - Parameters:
       - region: region to return instance for

     - Returns:
       An array of EC2s
    */
    func getInstancesByRegion(region: String) -> [EC2]? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        ec2Request.predicate = NSPredicate(format: "region == %@", region)

        return try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]
    }

    /**
     Returns an EC2 by instance ID

     - Parameters:
       - instanceId: unique Id of instance

     - Returns:
       Required EC2 or nil if not found
    */
    func getInstanceByInstanceId(instanceId: String) -> EC2? {

        let ec2Request = NSFetchRequest<EC2>(entityName: "EC2")
        ec2Request.predicate = NSPredicate(format: "instanceId == %@", instanceId)

        let result = try? persistentContainer.viewContext.fetch(ec2Request) as [EC2]
        if (result?.count)! > 0 {
            return result?[0]
        }

        return nil
    }
}
