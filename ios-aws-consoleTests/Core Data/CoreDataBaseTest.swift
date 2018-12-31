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

    lazy var persistentTestContainer: NSPersistentContainer = {

        let testContainer = NSPersistentContainer(name: "ios-aws-console_tests")
        testContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return testContainer
    }()

    func saveContext () {
        let context = persistentTestContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
