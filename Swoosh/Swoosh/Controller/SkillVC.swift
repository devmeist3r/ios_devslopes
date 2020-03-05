//
//  SkillVC.swift
//  Swoosh
//
//  Created by Lucas Inocencio on 01/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class SkillVC: UIViewController {
    
    var player: Player!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(player.desiredLeague)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
