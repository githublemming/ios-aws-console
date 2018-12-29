//
//  DetailViewController.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 28/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.id
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: EC2? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

