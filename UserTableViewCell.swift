//
//  UserTableViewCell.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/8/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - Fields
    
    var user: User = User()
    var delegate: ShowUsersTableViewController = ShowUsersTableViewController()
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNum: UILabel!
    @IBOutlet weak var icon: UIImageView!
    

    // MARK: - Lifecycle
    
    func setupCell() {
        userName.text = user.firstName + " " + user.lastName
        userNum.text = formatPhoneNum(phoneNum: user.phoneNumber)
    }
    
    func formatPhoneNum(phoneNum: String) -> String {
        var newString = user.phoneNumber
        newString.insert("-", at: newString.index(newString.startIndex, offsetBy: 3))
        newString.insert("-", at: newString.index(newString.startIndex, offsetBy: 7))
        return newString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
