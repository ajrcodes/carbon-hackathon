//
//  AddNearbyTableViewCell.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class AddNearbyTableViewCell: UITableViewCell {

    // MARK: - Fields
    
    var user: User = User()
    var addedToGroup: Bool = false
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var selectorIcon: UIButton!
    
    
    // MARK: - IBActions
    
    @IBAction func selectorPressed(_ sender: Any) {
        
        if !addedToGroup {
            // Reflect status in label
            selectorIcon.titleLabel?.text = "-"
            // Add user to group
            userGroup.users.append(user)
        } else {
            // Reflect status in label
            selectorIcon.titleLabel?.text = "+"
            // Remove user from group
        }
        
    }
    
    
    // MARK: - Lifecycle
    
    func setupCell() {
        name.text = user.firstName + user.lastName
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
