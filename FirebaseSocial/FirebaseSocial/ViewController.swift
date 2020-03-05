//
//  ViewController.swift
//  FirebaseSocial
//
//  Created by Lucas Inocencio on 01/10/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    // Outlets
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var btLogout: UIButton!
    @IBOutlet weak var btFacebookLogin: FBSDKLoginButton!
    
    //Variables
    let loginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        btFacebookLogin.delegate = self
        btFacebookLogin.readPermissions = ["email"]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.lbInfo.text = "No user logged in"
            } else {
                self.lbInfo.text = "Welcome user: \(user?.uid ?? "")"
            }
        }
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
        }
    }
    
    @IBAction func googleSignTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func logginGooglePressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            debugPrint("Failed facebook login", error)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: result.token.tokenString)
        firebaseLogin(credential)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    @IBAction func logginFacebookPressed(_ sender: Any) {
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if let error = error {
                debugPrint("could not login facebook", error)
            } else if result!.isCancelled {
                print("facebook login was cancelled")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseLogin(credential)
            }
        }
    }
    
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signoutError as NSError {
            debugPrint("Error signing out", signoutError)
        }
    }
    
    func logoutSocial() {
        guard let user = Auth.auth().currentUser else { return }
        
        for info in (user.providerData) {
            switch info.providerID {
            case GoogleAuthProviderID:
                GIDSignIn.sharedInstance()?.signOut()
                print("google")
            case TwitterAuthProviderID:
                print("twitter")
            case FacebookAuthProviderID:
                print("facebook")
                loginManager.logOut()
            default:
                break
            }
        }
    }
    
}

