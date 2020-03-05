//
//  CircleImage.swift
//  Smack
//
//  Created by Lucas Inocencio on 14/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
