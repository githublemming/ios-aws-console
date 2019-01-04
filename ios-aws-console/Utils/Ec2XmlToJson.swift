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

    func getJsonString(xml: XMLIndexer) -> String {

        enumerate(indexer: xml)

        return JSON(details).rawString(options: [])!
    }

    //
    // Doesn't currently handle nested XML tags
    //
    fileprivate func enumerate(indexer: XMLIndexer) {

        for item in indexer.children {

            if item.children.count == 0 {
                details.append([item.element!.name: item.element!.text])
            }
        }
    }
}
