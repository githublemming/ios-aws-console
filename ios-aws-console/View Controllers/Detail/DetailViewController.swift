//
//  DetailViewController.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 28/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var ec2: EC2?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var detailItem: EC2? {
        didSet {
            if ec2 != nil {
                ec2!.deflate()
            }

            ec2 = detailItem
            ec2!.inflate()
            tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if ec2 != nil {
            return ec2!.instanceDetail.count
        }
        else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell

//        let detail = ec2!.instanceDetail(indexPath.row)
//        cell.nameLabel?.text = detail.name
//        cell.valueLabel?.text = detail.value

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
