//
//  UserGroupTableViewCell.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit


class UserGroupTableViewCell: UITableViewCell {

    var user: User = User()
    var index: Int = 0
    var delegate: FinalizedGroupViewController = FinalizedGroupViewController()
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
   
    
    @IBAction func deletePressed(_ sender: Any) {
        userGroup.users.remove(at: index)
        delegate.tableview.reloadData()
    }
    
    
    // MARK: - Lifecycle
    
    func setupCell() {
        name.text = user.firstName + " " + user.lastName
        phoneNumber.text = formatPhoneNum(phoneNum: user.phoneNumber)
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
