//
//  GroupCell.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 05/07/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbNumberOfMembers: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.lbTitle.text = title
        self.lbDescription.text = description
        self.lbNumberOfMembers.text = "\(memberCount) members"
    }

}
