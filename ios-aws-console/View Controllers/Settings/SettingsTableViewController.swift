//
//  SettingsTableViewController.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 01/01/2019.
//  Copyright © 2019 Mark Haskins. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    let profileDao = ProfileDao()

    var profiles = [Profile]()

    var headers: [String] = [ "Profiles", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return profiles.count
        } else {
            return 5
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = (tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell)!
        } else {
            if indexPath.row < 4 {
                cell = (tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath) as? EditCell)!
            } else {
                cell = (tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as? ButtonCell)!
            }

        }

        if indexPath.section == 0 {
            (cell as! SettingsCell).cellLabel.text = profiles[indexPath.row].name
        } else {

            if indexPath.row < 4 {
                (cell as! EditCell).cellTextField.isHidden = false
                (cell as! EditCell).activeSwitch.isHidden = true
            }

            switch indexPath.row {
            case 0:
                (cell as! EditCell).cellLabel.text = "Name"
            case 1:
                (cell as! EditCell).cellLabel.text = "Access Id"
            case 2:
                (cell as! EditCell).cellLabel.text = "Secret"
            case 3:
                (cell as! EditCell).cellLabel.text = "Active"
                (cell as! EditCell).cellTextField.isHidden = true
                (cell as! EditCell).activeSwitch.isHidden = false
            case 4:
                print("button cell")
            default:
                print("error")
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 1 && indexPath.row == 4 {

            let nameCell = (tableView.dequeueReusableCell(withIdentifier: "EditCell", for: IndexPath(row: 0, section: 1)) as? EditCell)!
            let accessCell = (tableView.dequeueReusableCell(withIdentifier: "EditCell", for: IndexPath(row: 1, section: 1)) as? EditCell)!
            let secretCell = (tableView.dequeueReusableCell(withIdentifier: "EditCell", for: IndexPath(row: 2, section: 1)) as? EditCell)!
            let activeCell = (tableView.dequeueReusableCell(withIdentifier: "EditCell", for: IndexPath(row: 3, section: 1)) as? EditCell)!

            let name = nameCell.cellTextField.text!
            let accessId = accessCell.cellTextField.text!
            let secret = secretCell.cellTextField.text!
            let active = activeCell.activeSwitch.isOn

            if let profile = profileDao.addProfile(name: name, accessId: accessId, secret: secret, active: active) {
                profiles.append(profile)
                self.tableView.reloadData()
            }
        }
    }
}
