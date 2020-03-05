//
//  LoginVC.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 28/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var tfEmail: InsertTextField!
    @IBOutlet weak var tfPassword: InsertTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.delegate = self
        tfPassword.delegate = self
    }

    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        if tfEmail.text != nil && tfPassword.text != nil {
            // Login
            AuthService.instance.loginUser(withEmail: tfEmail.text!, andPassword: tfPassword.text!) { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
            }
            
            //Register
            AuthService.instance.registerUser(withEmail: tfEmail.text!, andPassword: tfPassword.text!) { (success, registerError) in
                if success {
                    AuthService.instance.loginUser(withEmail: self.tfEmail.text!, andPassword: self.tfPassword.text!, loginComplete: { (success, nil) in
                        self.dismiss(animated: true, completion: nil)
                        print("Successfully registered user")
                    })
                } else {
                    print(String(describing: registerError?.localizedDescription))
                }
            }
            
        }
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
}
