//
//  EC2.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData
import SwiftyXMLParser

class EC2: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EC2> {
        return NSFetchRequest<EC2>(entityName: "EC2")
    }

    @NSManaged public var instanceId: String
    @NSManaged public var region: String
    @NSManaged public var xml: String

    var instanceDetail = [(name: String, value: String)]()

    func inflateMinimum() {

        instanceDetail = [(name: String, value: String)]()

        let xmlData = try! XML.parse(xml)
        instanceDetail[0] = (name: "Instance Id", value: xmlData["item", "instanceId"].text!)
        instanceDetail[2] = (name: "Status", value: xmlData["item", "instanceState", "name"].text!)

    }

    func inflate() {

        instanceDetail = [(name: String, value: String)]()

        let xmlData = try! XML.parse(xml)
        instanceDetail[0] = (name: "Instance Id", value: xmlData["item", "instanceId"].text!)
        instanceDetail[1] = (name: "Image Id", value: xmlData["item", "imageId"].text!)
        instanceDetail[2] = (name: "Status", value: xmlData["item", "instanceState", "name"].text!)
    }

    func deflate() {
        instanceDetail = [(name: String, value: String)]()
    }

    func getInstanceId() -> String {
        return instanceDetail[0].value
    }

    func getInstanceState() -> String {
        return instanceDetail[2].value
    }
}
