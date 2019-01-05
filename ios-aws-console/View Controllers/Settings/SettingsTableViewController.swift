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
        profiles = profileDao.getProfiles()!
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            if profiles.count == 0 {
                return 1
            } else {
                return profiles.count
            }

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

            if profiles.count == 0 {
                (cell as? SettingsCell)?.cellLabel.text = "No Profiles Defined"
            } else {
                (cell as? SettingsCell)?.cellLabel.text = profiles[indexPath.row].name
            }

        } else {

            if indexPath.row < 4 {
                (cell as? EditCell)?.cellTextField.isHidden = false
                (cell as? EditCell)?.activeSwitch.isHidden = true
            }

            switch indexPath.row {
            case 0:
                (cell as? EditCell)?.cellLabel.text = "Name"
                (cell as? EditCell)?.cellTextField.addTarget(self, action: #selector(SettingsTableViewController.nameChanged), for: .allEvents)
            case 1:
                (cell as? EditCell)?.cellLabel.text = "Access Id"
                (cell as? EditCell)?.cellTextField.addTarget(self, action: #selector(SettingsTableViewController.accessChanged), for: .allEvents)
            case 2:
                (cell as? EditCell)?.cellLabel.text = "Secret"
                (cell as? EditCell)?.cellTextField.isSecureTextEntry = true
                (cell as? EditCell)?.cellTextField.addTarget(self, action: #selector(SettingsTableViewController.secretChanged), for: .allEvents)
            case 3:
                (cell as? EditCell)?.cellLabel.text = "Active"
                (cell as? EditCell)?.cellTextField.isHidden = true
                (cell as? EditCell)?.activeSwitch.isHidden = false
                (cell as? EditCell)?.activeSwitch.addTarget(self, action: #selector(SettingsTableViewController.activeChanged), for: .allEvents)
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

            if profileNameValid && profileAccessIdValid && profileSecretValid {
                if let profile = profileDao.addProfile(name: profileName, accessId: profileAccessId, secret: profileSecret, active: profileActive) {
                    profiles.append(profile)
                    self.tableView.reloadData()
                }
            }
        }
    }

    var profileName = ""
    var profileNameValid = true
    @objc func nameChanged(textField: UITextField) {
        profileName = textField.text!
    }

    var profileAccessId = ""
    var profileAccessIdValid = false
    let accessPredicate = NSPredicate(format: "self MATCHES %@", "^(?<![A-Z0-9])[A-Z0-9]{20}(?![A-Z0-9])$")
    @objc func accessChanged(textField: UITextField) {
        profileAccessId = textField.text!
        profileAccessIdValid = accessPredicate.evaluate(with: profileAccessId)
    }

    var profileSecret = ""
    var profileSecretValid = false
    let secretPredicate = NSPredicate(format: "self MATCHES %@", "^(?<![A-Za-z0-9/+=])[A-Za-z0-9/+=]{40}(?![A-Za-z0-9/+=])$")
    @objc func secretChanged(textField: UITextField) {
        profileSecret = textField.text!
        profileSecretValid = secretPredicate.evaluate(with: profileSecret)
    }

    var profileActive = false
    @objc func activeChanged(activeSwitch: UISwitch) {
        profileActive = activeSwitch.isOn
    }
}
