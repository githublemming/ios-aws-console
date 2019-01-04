//
//  CoreDataBaseTest.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import XCTest
import CoreData

@testable import ios_aws_console

class CoreDataBaseTest: XCTestCase {

    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PersistentCoreData", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

    func flushData(entityName: String) {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        if let objs = try? mockPersistantContainer.viewContext.fetch(fetchRequest) {
            for case let obj as NSManagedObject in objs {
                mockPersistantContainer.viewContext.delete(obj)
            }
            try? mockPersistantContainer.viewContext.save()
        }
    }

    //Convenient method for getting the number of data in store now
    func numberOfItemsInPersistentStore(entityName: String) -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let results = try? mockPersistantContainer.viewContext.fetch(request)
        return results!.count
    }

    override func setUp() {

        super.setUp()

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
    }
}
