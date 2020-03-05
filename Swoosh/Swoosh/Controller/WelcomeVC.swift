//
//  WelcomeVC.swift
//  Swoosh
//
//  Created by Lucas Inocencio on 01/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func getStartTouched(_ sender: Any) {
        performSegue(withIdentifier: "begginerSegue", sender: nil)
    }
    
    
    @IBAction func unwindFromSkillVC(unwindSegue: UIStoryboardSegue) {
        
    }
}
