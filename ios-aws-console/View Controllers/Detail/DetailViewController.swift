//
//  DetailViewController.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 28/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var instanceDetails = [[String: String]]()

    let ec2Dao = Ec2Dao()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var instanceId: String? {
        didSet {

            if let ec2 = ec2Dao.getInstanceByInstanceId(instanceId: instanceId!) {

                let detail = ec2.detail
                let json = JSON(detail!.data(using: .utf8, allowLossyConversion: false)!)

                for (_, subJson):(String, JSON) in json {

                    let detail = subJson.dictionaryObject
                    instanceDetails.append(detail as! [String: String])
                }

                tableView.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instanceDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell

        let detail = instanceDetails[indexPath.row]
        for (property, value) in detail {
            cell.nameLabel?.text = property
            cell.valueLabel?.text = value
        }
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell

        if cell.nameLabel.text == "Status" {

            let optionMenu = UIAlertController(title: nil, message: "Instance State", preferredStyle: .actionSheet)

            let startAction = UIAlertAction(title: "Start", style: .default)
            let stopAction = UIAlertAction(title: "Stop", style: .default)
            let stopHibernateAction = UIAlertAction(title: "Stop - Hibernate", style: .default)
            let rebootAction = UIAlertAction(title: "Reboot", style: .default)
            let terminateAction = UIAlertAction(title: "Terminate", style: .default)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            optionMenu.addAction(startAction)
            optionMenu.addAction(stopAction)
            optionMenu.addAction(stopHibernateAction)
            optionMenu.addAction(rebootAction)
            optionMenu.addAction(terminateAction)

            optionMenu.addAction(cancelAction)

            self.present(optionMenu, animated: true, completion: nil)
        }
    }
}
