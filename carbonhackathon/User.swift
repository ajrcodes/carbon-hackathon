//
//  User.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import Foundation

class User: NSObject {
    
    // Fields
    
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var index: Int
    
    override init() {
        self.firstName = "John"
        self.lastName = "Doe"
        self.phoneNumber = "###-###-####"
        self.index = -1
    }
    
    init(firstName: String, lastName: String, phoneNumber: String, index: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.index = index
    }
    
    
}

struct userGroup {
    
    // Fields
    static var users: [User] = []
    
    func delete(user: User) {
        
        userGroup.users.remove(at: user.index)
        
    }
    
}
