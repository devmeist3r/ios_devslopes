//
//  AppDelegate.swift
//  FirebaseSocial
//
//  Created by Lucas Inocencio on 01/10/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        // Facebook
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            debugPrint("Could not login with google: \(error)")
        } else {
            guard let controller = GIDSignIn.sharedInstance()?.uiDelegate as? ViewController else { return }
            guard let authetication = user.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: authetication.idToken, accessToken: authetication.accessToken)
            controller.firebaseLogin(credential)
        }
    }
    
    // Facebook
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let returnGoogle = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        let returnFB = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
//        let returnTwitter = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        
        return returnGoogle || returnFB
        
    }

}


