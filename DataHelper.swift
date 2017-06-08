//
//  DataHelper.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/8/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit
import CoreData

class DataHelper {
    
    // MARK: - Save data
    
    class func saveGroupToCoreData(group: [User]) -> Bool {
        // 1 - setup CoreData stuff
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let groupEntity = UserGroupEntity(context: managedContext)
        // Set groupname to random num
        let randomNum:UInt32 = arc4random_uniform(100) // range is 0 to 99
        let nameAsString:String = String(randomNum) //string works too
        groupEntity.name = nameAsString
        
        // 2 - Add users to group relationship
        for user in group {
            let userEntity = saveUserToCoreData(user: user)
            userEntity.addToInGroup(groupEntity)
        }
        
        // 3 - save the data
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        print("Yeah this worked!")
        return true
    }
    
    class func saveUserToCoreData(user: User) -> UserEntity {
        // 1 - setup CoreData stuff
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return UserEntity()
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = UserEntity(context: managedContext)
        userEntity.fname = user.firstName
        userEntity.lname = user.lastName
        userEntity.phoneNum = user.phoneNumber
        
        // 3 - save the data
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        print("Yeah this worked!")
        return userEntity
    }
    
    
    // MARK: - Store data
    
    class func retrieveGroupsFromCoreData() -> [Group] {
        //1 - setup context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 - make fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserGroupEntity")
        var fetchArray: [NSManagedObject] = []
        do {
            fetchArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        //3 - translate fetch request into array of structs
        var groups: [Group] = []
        
        for group in fetchArray {
            let object = group as! UserGroupEntity
            // fetch related users for the group
            var users: [User] = []
            for user in object.hasUser! {
                let userEntity = user as! UserEntity
                let userStruct = User(firstName: userEntity.fname!, lastName: userEntity.lname!, phoneNumber: userEntity.phoneNum!)
                users.append(userStruct)
            }
            // then translate the CoreData entity into a struct we can use
            let groupStruct = Group(name: object.name!)
            groupStruct.users = users
            groups.append(groupStruct)
        }
        return groups
    }
}
