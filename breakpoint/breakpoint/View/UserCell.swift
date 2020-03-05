//
//  UserCell.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 30/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var ivCheckImage: UIImageView!
    
    var showing = false
    
    func confoigureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.ivProfileImage.image = image
        self.lbEmail.text = email
        
        if isSelected {
            self.ivCheckImage.isHidden = false
        } else {
            self.ivCheckImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                ivCheckImage.isHidden = false
                showing = true
            } else {
                ivCheckImage.isHidden = true
                showing = false
            }
        }
    }
    
    
}
