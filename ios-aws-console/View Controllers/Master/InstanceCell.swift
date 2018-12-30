//
//  InstanceCell.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 29/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit
import SwiftyXMLParser

class InstanceCell: UICollectionViewCell {

    var ec2 : EC2!

    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var instanceId: UILabel!
    
    func configure() {

        if let xml = ec2.xml {
            let instanceData = try! XML.parse(xml)

            instanceId.text = instanceData["item", "instanceId"].text

            let code = instanceData["item", "instanceState", "code"].text
            switch(code) {
            case "0", "32":
                stateView.backgroundColor = UIColor.yellow
            case "16":
                stateView.backgroundColor = UIColor.green
            case "48", "64", "80":
                stateView.backgroundColor = UIColor.red
            default:
                stateView.backgroundColor = UIColor.gray
            }
        }
    }
}
