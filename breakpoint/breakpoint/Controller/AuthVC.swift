//
//  AuthVC.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 28/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signFacebookPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func signGoogle(_ sender: UIButton) {
        
    }
    
    
    @IBAction func signInWithEmailPressed(_ sender: Any) {
        let loginVc = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVc!, animated: true, completion: nil)
    }
}
