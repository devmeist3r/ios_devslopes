//
//  CreateAccountVC.swift
//  RNDM
//
//  Created by Lucas Inocencio on 28/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btCreateAccount: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    func setUpView() {
        tfEmail.layer.cornerRadius = 10
        tfEmail.addPadding(.left(10))
        tfEmail.addPadding(.right(10))
        
        tfUsername.layer.cornerRadius = 10
        tfUsername.addPadding(.left(10))
        tfUsername.addPadding(.right(10))
        
        tfPassword.layer.cornerRadius = 10
        tfPassword.addPadding(.left(10))
        tfPassword.addPadding(.right(10))
        
        btCreateAccount.layer.cornerRadius = 10
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTapped(_ sender: Any) {
        
        guard let email = tfEmail.text, tfEmail.text != "" else { return }
        guard let username = tfUsername.text, tfUsername.text != "" else { return }
        guard let password = tfPassword.text, tfPassword.text != "" else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
            }
            
            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
            })
            
            guard let userId = user?.user.uid else { return }
            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME: username,
                DATE_CREATE: FieldValue.serverTimestamp()
                ], completion: { (error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: "toHomeScreen", sender: nil)
                    }
            })
        }
    }
    
    
}
