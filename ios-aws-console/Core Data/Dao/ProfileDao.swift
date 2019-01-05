//
//  Ec2Dao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

/// DAO class that deals with Profile models in Core Data
class ProfileDao: BaseDao {

    /**
     Adds a new Profile into Core Data

     - Parameters:
       - name: name of the profile
       - accessId: Access Key Id
       - secret: Access Key Secret
       - active: Is this the activce profile?

     - Returns:
       Profile object if successful otherwise nil
    */
    @discardableResult func addProfile(name: String, accessId: String, secret: String, active: Bool) -> Profile? {

        guard let profile = NSEntityDescription.insertNewObject(
            forEntityName: "Profile", into: persistentContainer.viewContext) as? Profile else { return nil }

        profile.name = name
        profile.active = active
        profile.access_id = accessId
        profile.secret = secret

        save()

        return profile
    }

    /**
     Returns an array of all Profiles

     - Returns:
       Array of Profile objects
    */
    func getProfiles() -> [Profile]? {

        let profileRequest = NSFetchRequest<Profile>(entityName: "Profile")
        let profiles = try? persistentContainer.viewContext.fetch(profileRequest) as [Profile]

        return profiles
    }

    /**
     Returns a Profile with a specific name

     - Parameters:
      - name : The name of the profile to return

     - Returns:
       The required profile or nil if not found
    */
    func getProfileByName(name: String) -> Profile? {

        let profileRequest = NSFetchRequest<Profile>(entityName: "Profile")
        profileRequest.predicate = NSPredicate(format: "name == %@", name)

        let result = try? persistentContainer.viewContext.fetch(profileRequest) as [Profile]
        if (result?.count)! > 0 {
            return result?[0]
        }
        return nil
    }

    /**
     Returns the active Profile

     - Returns:
       Returns a Profile object or nil if no profiles are defined as active
    */
    func getActiveProfile() -> Profile? {

        let profileRequest = NSFetchRequest<Profile>(entityName: "Profile")
        profileRequest.predicate = NSPredicate(format: "active == %@", NSNumber(booleanLiteral: true))

        let result = try? persistentContainer.viewContext.fetch(profileRequest) as [Profile]
        if (result?.count)! > 0 {
            return result?[0]
        }
        return nil
    }

    /**
     Sets a Profile as active

     - Parameters:
       - profile: The Profile to set as active
    */
    func setActiveProfile(profile: Profile) {

        if let activeProfile = getActiveProfile() {
            activeProfile.active = false
        }

        profile.active = true

        save()
    }
}
