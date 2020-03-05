//
//  FeedCell.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 28/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var tfEmail: UILabel!
    @IBOutlet weak var tfMessages: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.ivProfileImage.image = profileImage
        self.tfEmail.text = email
        self.tfMessages.text = content
    }
}
