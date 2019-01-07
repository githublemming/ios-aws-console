//
//  InstanceCell.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 29/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

class InstanceCell: UICollectionViewCell {

    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var instanceId: UILabel!

    func configure(instanceState: String) {

        switch instanceState {
        case "pending", "shutting-down", "stopping":
            stateView.backgroundColor = UIColor.yellow
        case "running":
            stateView.backgroundColor = UIColor.green
        case "terminated", "stopped":
            stateView.backgroundColor = UIColor.red
        default:
            stateView.backgroundColor = UIColor.gray
        }

    }
}
