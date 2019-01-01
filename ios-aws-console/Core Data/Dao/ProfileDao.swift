//
//  Ec2Dao.swift
//  ios-aws-console
//
//  Created by Mark Haskins on 30/12/2018.
//  Copyright © 2018 Mark Haskins. All rights reserved.
//

import CoreData

class ProfileDao: BaseDao {

    func addProfile(name: String, accessId: String, secret: String, active: Bool) -> Profile? {

        guard let profile = NSEntityDescription.insertNewObject(
            forEntityName: "Profile", into: persistentContainer.viewContext) as? Profile else { return nil }

        profile.name = name
        profile.active = active
        profile.access_id = accessId
        profile.secret = secret

        save()

        return profile
    }

    func getProfiles() -> [Profile]? {

        let profileRequest = NSFetchRequest<Profile>(entityName: "Profile")
        let profiles = try? persistentContainer.viewContext.fetch(profileRequest) as [Profile]

        return profiles
    }

    func getProfileByName(name: String) -> Profile? {

        let profileRequest = NSFetchRequest<Profile>(entityName: "Profile")
        profileRequest.predicate = NSPredicate(format: "name == %i", name)

        let result = try? persistentContainer.viewContext.fetch(profileRequest) as [Profile]
        return result?[0]
    }

    func getActiveProfile() -> Profile? {

        let profileRequest = NSFetchRequest<Profile>(entityName: "Profile")
        profileRequest.predicate = NSPredicate(format: "active == %i", true)

        let result = try? persistentContainer.viewContext.fetch(profileRequest) as [Profile]
        if (result?.count)! > 0 {
            return result?[0]
        }
        return nil
    }

    func setActiveProfile(profile: Profile) {

        if let activeProfile = getActiveProfile() {
            activeProfile.active = false
        }

        profile.active = true

        save()
    }
}
