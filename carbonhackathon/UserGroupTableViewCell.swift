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
    
    @IBAction func deletePressed(_ sender: Any) {
        userGroup.users.remove(at: index)
        delegate.tableview.reloadData()
    }
    
    
    
    
    func setupCell() {
        name.text = user.firstName + " " + user.lastName
        phoneNumber.text = user.phoneNumber
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
