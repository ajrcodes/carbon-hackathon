//
//  User.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import Foundation
import UIKit

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

func userImage(user: User) -> UIImage {
    // Getting the initials
    let firstname = user.firstName
    let lastname = user.lastName
    let index1 = firstname.index(firstname.startIndex, offsetBy: 1)
    let index2 = lastname.index(lastname.startIndex, offsetBy: 1)
    let userInitial = firstname.substring(to: index1) + lastname.substring(to: index2)
    
    // Drawing the circle & adding text
    var userImage = UIImage()
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 30), false, 0.0)
    
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.saveGState()
    
    let rect = CGRect(x: 0, y: 0, width: 30, height: 30)
    ctx.setFillColor(UIColor.blue.cgColor)
    ctx.fillEllipse(in: rect)
    
    ctx.restoreGState()
    userImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    // Adding text
    let textColor = UIColor.white
    let textFont = UIFont(name: "Helvetica Bold", size: 12)!
    
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(userImage.size, false, scale)
    
    let textFontAttributes = [
        NSFontAttributeName: textFont,
        NSForegroundColorAttributeName: textColor,
        ] as [String : Any]
    
    userImage.draw(in: CGRect(origin: CGPoint.zero, size: userImage.size))
    
    let rect1 = CGRect(x: 0, y: 0, width: 30, height: 30)
    userInitial.draw(in: rect1, withAttributes: textFontAttributes)
    
    userImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return userImage
}
