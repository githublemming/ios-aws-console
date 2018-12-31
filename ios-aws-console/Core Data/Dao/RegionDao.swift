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

    func regionExists(region: String) -> Bool {
        return false
    }

    func getDefaultRegion() -> Region? {
        return nil
    }

    func setDefaultRegion(region: String) {

    }
}
