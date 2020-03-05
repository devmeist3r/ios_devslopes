//
//  LoginVC.swift
//  Smack
//
//  Created by Lucas Inocencio on 13/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // Actions
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: RoundedButton) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = tfUsername.text, tfUsername.text != "" else { return }
        guard let password = tfPassword.text, tfPassword.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (succees) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    
    @IBAction func signUPPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    func setupView() {
        spinner.isHidden = true
        tfUsername.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap )
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
}
