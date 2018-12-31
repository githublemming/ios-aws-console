//
//  DetailCell.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

class RegionPickerView: UIPickerView  {

    let regionDao = RegionDao()
    let ec2Service = Ec2Service()

    var regions: [String] = [
        "ap-south-1",
        "eu-west-3",
        "eu-north-1",
        "eu-west-2",
        "eu-west-1",
        "ap-northeast-2",
        "ap-northeast-1",
        "sa-east-1",
        "ca-central-1",
        "ap-southeast-1",
        "ap-southeast-2",
        "eu-central-1",
        "us-east-1",
        "us-east-2",
        "us-west-1",
        "us-west-2"]

    func viewDidLoad() {
        regions.sort()

        NotificationCenter.default.addObserver(self, selector: #selector(regionsUpdated), name: .regionsUpdated, object: nil)
        ec2Service.describeRegions()
    }

    func selectedRegion(row: Int) -> String {
        return regions[row]
    }

    @objc func regionsUpdated() {

        let regionObjs = regionDao.getRegions()!

        if regionObjs.count > 0 {

            // clear array
            regions = [String]()

            // repopulate from DAO
            for reg in regionObjs {
                regions.append(reg.name!)
            }

            regions.sort()
            self.reloadAllComponents()
        }
    }
}

extension RegionPickerView: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row]
    }
}
