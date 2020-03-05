//
//  GroupFeedCell.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 06/07/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    
    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.ivProfileImage.image = profileImage
        self.lbEmail.text = email
        self.lbContent.text = content
    }
    
}
