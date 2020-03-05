//
//  BorderButton.swift
//  Swoosh
//
//  Created by Lucas Inocencio on 01/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
    
    override func awakeFromNib() {
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }
    
}
