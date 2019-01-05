//
//  RegionDao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

/// DAO class that handles the Region object
class RegionDao: BaseDao {

    /**
     Created a new Region object in Core Data

     - Parameters:
       - name: name of the region
       - active: is the region active

     - Returns:
       The created Region or nil of the request was not sucessful
    */
    @discardableResult func addRegion(name: String, active: Bool) -> Region? {

        guard let region = NSEntityDescription.insertNewObject(
            forEntityName: "Region", into: persistentContainer.viewContext) as? Region else { return nil }

        region.name = name
        region.active = active

        save()

        return region
    }

    /**
     Returns all Regions

     - Returns:
       An array of Region objects
    */
    func getRegions() -> [Region]? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        let regions = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]

        return regions
    }

    /**
     Returns a Region by name

     - Parameters:
       - name: name of the Region to return

     - Returns:
       The required Region or nil if it could not be found
    */
    func getRegionByName(name: String) -> Region? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        regionRequest.predicate = NSPredicate(format: "name == %@", name)

        let result = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]

        if (result?.count)! > 0 {
            return result?[0]
        }

        return nil
    }

    /**
     Returns the active Region

     - Returns:
       The active Region or nil if no active region has been defined
    */
    func getActiveRegion() -> Region? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        regionRequest.predicate = NSPredicate(format: "active == %@", NSNumber(booleanLiteral: true))

        let result = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]
        return result?[0]
    }

    /**
     Sets the Region as active

     - Parameters:
       - region: Region to set as active
    */
    func setActiveRegion(region: Region) {

        if let activeRegion = getActiveRegion() {
            activeRegion.active = false
        }

        region.active = true

        save()
    }
}
