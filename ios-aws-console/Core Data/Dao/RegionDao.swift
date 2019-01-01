//
//  RegionDao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData
import SwiftyXMLParser

class RegionDao: BaseDao {

    func getRegions() -> [Region]? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        let regions = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]

        return regions
    }

    func getRegionByName(name: String) -> Region? {

        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        regionRequest.predicate = NSPredicate(format: "name == %i", true)

        let result = try? persistentContainer.viewContext.fetch(regionRequest) as [Region]
        return result?[0]
    }

    func getActiveRegion() -> Region? {
        
        let regionRequest = NSFetchRequest<Region>(entityName: "Region")
        regionRequest.predicate = NSPredicate(format: "active == %i", true)

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
