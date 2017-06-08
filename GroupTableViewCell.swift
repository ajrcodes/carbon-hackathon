//
//  GroupTableViewCell.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/8/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: - Fields
    
    var group: Group = Group(name: "default", descrip: "default")
    var delegate: ShowGroupsViewController = ShowGroupsViewController()

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    // MARK: - Lifecycle
    
    func setupCell() {
        groupName.text = group.name
        groupDescription.text = group.descrip
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
