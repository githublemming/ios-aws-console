//
//  RegionDao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

class RegionDao: BaseDao {

    @discardableResult func addRegion(name: String, active: Bool) -> Region? {

        guard let region = NSEntityDescription.insertNewObject(
            forEntityName: "Region", into: persistentContainer.viewContext) as? Region else { return nil }

        region.name = name
        region.active = active

        save()

        return region
    }

    func getRegions() -> [Region]? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        let regions = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]

        return regions
    }

    func getRegionByName(name: String) -> Region? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        regionRequest.predicate = NSPredicate(format: "name == %@", name)

        let result = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]

        if (result?.count)! > 0 {
            return result?[0]
        } else {
            return nil
        }
    }

    func getActiveRegion() -> Region? {
        
        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        regionRequest.predicate = NSPredicate(format: "active == %@", NSNumber(booleanLiteral: true))

        let result = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]
        return result?[0]
    }

    func setActiveRegion(region: Region) {

        if let activeRegion = getActiveRegion() {
            activeRegion.active = false
        }

        region.active = true

        save()
    }
}
