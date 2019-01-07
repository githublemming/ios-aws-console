//
//  MasterViewController.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 28/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var regionPicker: UIPickerView!
    @IBOutlet weak var navBar: UINavigationItem!

    var detailViewController: DetailViewController?

    var regions: [String] = [ "ap-south-1", "eu-west-3", "eu-north-1", "eu-west-2", "eu-west-1",
        "ap-northeast-2", "ap-northeast-1", "sa-east-1", "ca-central-1", "ap-southeast-1",
        "ap-southeast-2", "eu-central-1", "us-east-1", "us-east-2", "us-west-1", "us-west-2"]

    let ec2Dao = Ec2Dao()
    let regionDao = RegionDao()
    let profileDao = ProfileDao()

    var ec2Service: Ec2Service!

    fileprivate let reuseIdentifier = "Cell"

    var instances = [EC2]()
    var region = "eu-west-1"

    override func viewDidLoad() {

        super.viewDidLoad()

        doneWithPickerView()

        if let split = splitViewController {

            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as!
                UINavigationController).topViewController as? DetailViewController
        }

        ec2Service = Ec2Service(ec2Dao: ec2Dao, regionDao: regionDao, profileDao: profileDao)

        navBar.title = region
        regions.sort()

        let indexArray = regions.index(of: region)!
        regionPicker.selectRow(indexArray, inComponent: 0, animated: false)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshInstances),
                                               name: .instancesUpdated,
                                               object: nil)
    }

    @IBAction func changRegion(_ sender: Any) {

        UIView.animate(withDuration: 0.3, animations: {
             self.regionPicker.frame = CGRect(x: 0,
                                              y: self.view.bounds.size.height - self.regionPicker.bounds.size.height,
                                              width: self.regionPicker.bounds.size.width,
                                              height: self.regionPicker.bounds.size.height)
             })

         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneWithPickerView))
         view.addGestureRecognizer(tapGesture)
    }

    @IBAction func reload(_ sender: Any) {
        ec2Service.describeInstances(region: region)
    }

    @IBAction func showSettings(_ sender: Any) {
        print("settinggs")
    }

    @objc func doneWithPickerView() {

        UIView.animate(withDuration: 0.3, animations: {
            self.regionPicker.frame = CGRect(x: 0,
                                             y: self.view.bounds.size.height,
                                             width: self.regionPicker.bounds.size.width,
                                             height: self.regionPicker.bounds.size.height)
        })

        refreshInstances()
    }

    @objc func refreshInstances() {

        instances = ec2Dao.getInstancesByRegion(region: region)!

        collectionView.reloadData()
    }
}

extension MasterViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instances.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! InstanceCell

        let ec2 = instances[indexPath.row]
        cell.instanceId.text = ec2.instanceId!
        cell.configure(instanceState: ec2.instanceState!)
        return cell
    }
}

extension MasterViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let instanceId = instances[indexPath.row].instanceId!

        detailViewController!.instanceId = instanceId
    }
}

extension MasterViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row]
    }
}

extension MasterViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        region = regions[row]
        navBar.title = region
    }
}
