//
//  NotificationNames.swift
//  ios-aws-consoleTests
//
//  Created by Mark Haskins on 31/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import UIKit

/// Additional Notification names
extension Notification.Name {

    /// Used when instances are updated
    static let instancesUpdated = Notification.Name("instancesUpdated")

    /// Used when regions are updated
    static let regionsUpdated = Notification.Name("regionsUpdated")
}
