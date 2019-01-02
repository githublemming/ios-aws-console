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

    var regions: [String] = [ "ap-south-1", "eu-west-3", "eu-north-1", "eu-west-2", "eu-west-1",
        "ap-northeast-2", "ap-northeast-1", "sa-east-1", "ca-central-1", "ap-southeast-1",
        "ap-southeast-2", "eu-central-1", "us-east-1", "us-east-2", "us-west-1", "us-west-2"]

    let ec2Dao = Ec2Dao()
    let regionDao = RegionDao()

    let ec2Service = Ec2Service()

    fileprivate let reuseIdentifier = "Cell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

    var instances = [EC2]()
    var region = "eu-west-1"

    override func viewDidLoad() {

        super.viewDidLoad()

        navBar.title = region

        regions.sort()

        doneWithPickerView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshInstances),
                                               name: .instancesUpdated,
                                               object: nil)
//        refreshInstances()
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
        
        instances = ec2Dao.getInstances(region: region)!

        if instances.count > 0 {
            collectionView.reloadData()
        } else {
            // alert that there are no known instances and that the user should request a refresh
        }
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
        cell.ec2 = instances[indexPath.row]
        cell.configure()
        return cell
    }
}

extension MasterViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("Something tapped")
        return false
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
