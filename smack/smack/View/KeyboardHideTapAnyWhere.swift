//
//  KeyboardHideTapAnyWhere.swift
//  Smack
//
//  Created by Lucas Inocencio on 19/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import Foundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
