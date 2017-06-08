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
    
    override init() {
        self.firstName = "John"
        self.lastName = "Doe"
        self.phoneNumber = "###-###-####"
    }
    
    init(firstName: String, lastName: String, phoneNumber: String) {
        self.firstName = firstName.removingWhitespaces()
        self.lastName = lastName.removingWhitespaces()
        self.phoneNumber = phoneNumber.removingWhitespaces()
    }
    
    
}


class Group {
    var name: String
    var descrip: String
    var users: [User]
    
    init(name: String, descrip: String) {
        self.name = name
        self.descrip = descrip
        self.users = []
    }
}


struct userGroup {
    // Fields
    static var defaultUser: User = User()
    static var users: [User] = []
    static var groups: [Group] = []
}
