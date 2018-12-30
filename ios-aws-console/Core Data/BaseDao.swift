//
//  BaseDao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit
import CoreData

class BaseDao {

    let persistentContainer: NSPersistentContainer!

    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }

    func save() {
        try? self.persistentContainer.viewContext.save()
    }

    func save(entity: NSManagedObject) {

        do {
            try entity.managedObjectContext?.save()
        } catch {
            print("Failed to save quiz: \(error)")
        }
    }
}
