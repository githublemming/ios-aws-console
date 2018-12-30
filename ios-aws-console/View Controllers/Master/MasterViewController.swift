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

    let ec2Dao = Ec2Dao()

    fileprivate let reuseIdentifier = "Cell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

    var instances = [EC2]()

    override func viewDidLoad() {
        super.viewDidLoad()

        instances = ec2Dao.getInstances(region: "eu-west-1")!
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
