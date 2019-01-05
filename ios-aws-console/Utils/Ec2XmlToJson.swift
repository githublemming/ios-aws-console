//
//  Ec2XmlToJson.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 04/01/2019.
//  Copyright © 2019 Mark Haskins. All rights reserved.
//

import SWXMLHash
import SwiftyJSON

class Ec2XmltoJson {

    var details = [[String: String]]()

    /**
     Returns a JSON Array of Dictionaries of the passed XML as a String

     - Parameters:
       - xml: XMLIndexer to be parsed

     - Returns:
       A String representation of JSON
    */
    func getJsonString(xml: XMLIndexer) -> String {
        return getJson(xml: xml).rawString(options: [])!
    }

    /**
     Returns a JSON Array of Dictionaries of the passed XML

     - Parameters:
       - xml: XMLIndexer to be parsed

     - Returns:
       A JSON object
     */
    func getJson(xml: XMLIndexer) -> JSON {
        enumerate(indexer: xml)
        return JSON(details)
    }

    /**
     Iterates around the XML object adding the name of the element and it's value
     to a dictionary/

     This doesn't handle nested XML at this time

     - Parameters:
       - indexer: XMLIndexer to be parsed
    */
    fileprivate func enumerate(indexer: XMLIndexer) {

        for item in indexer.children where item.children.count == 0 {
            details.append([item.element!.name: item.element!.text])
        }
    }
}
