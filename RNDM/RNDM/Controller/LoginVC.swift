//
//  LoginVC.swift
//  RNDM
//
//  Created by Lucas Inocencio on 28/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btCreateAccount: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    func setUpView() {
        tfEmail.layer.cornerRadius = 10
        tfEmail.addPadding(.left(10))
        tfEmail.addPadding(.right(10))
        
        tfPassword.layer.cornerRadius = 10
        tfPassword.addPadding(.left(10))
        tfPassword.addPadding(.right(10))
        
        btLogin.layer.cornerRadius = 10
        btCreateAccount.layer.cornerRadius = 10
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -210, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -210, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animatedTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = tfEmail.text, tfEmail.text != "" else { return }
        guard let password = tfPassword.text, tfPassword.text != "" else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
            } else {
               self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
