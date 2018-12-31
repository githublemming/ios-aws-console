//
//  MasterViewController.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 28/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var regionPicker: RegionPickerView!
    
    let ec2Dao = Ec2Dao()
    let regionDao = RegionDao()

    let ec2Service = Ec2Service()

    fileprivate let reuseIdentifier = "Cell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

    var instances = [EC2]()
    var region = "eu-west-1"

    override func viewDidLoad() {
        super.viewDidLoad()

        // if we have a default region overwrite the variable

        NotificationCenter.default.addObserver(self, selector: #selector(refreshInstances), name: .instancesUpdated, object: nil)
//        refreshInstances()

        self.regionPicker.isHidden = true
        self.regionPicker.delegate = self
    }

    // @IBAction
    func ec2DescribeInstances() {
        ec2Service.describeInstances(region: region)
    }

    // @IBAction
    func changeRegion() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.regionPicker.frame = CGRect(x: 0, y: self.view.bounds.size.height - self.regionPicker.bounds.size.height, width: self.regionPicker.bounds.size.width, height: self.regionPicker.bounds.size.height)
        })

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneWithPickerView))
        view.addGestureRecognizer(tapGesture)
    }

    // @IBAction
    func showSettings() {
        // this allows you to set a set of AWS credentials
        // change AWS Profile
    }

    @objc func doneWithPickerView() {

        UIView.animate(withDuration: 0.3, animations: {
            self.regionPicker.frame = CGRect(x: 0, y: self.view.bounds.size.height, width: self.regionPicker.bounds.size.width, height: self.regionPicker.bounds.size.height)
        })

        refreshInstances();
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

extension MasterViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instances.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InstanceCell
        cell.ec2 = instances[indexPath.row]
        cell.configure()
        return cell
    }
}

extension MasterViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("Something tapped")
        return false
    }
}

extension MasterViewController : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let regionPickerView = pickerView as! RegionPickerView
        region = regionPickerView.selectedRegion(row: row)
        regionDao.setDefaultRegion(region: region)
    }
}
