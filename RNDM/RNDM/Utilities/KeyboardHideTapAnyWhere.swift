//
//  KeyboardHideTapAnyWhere.swift
//  RNDM
//
//  Created by Lucas Inocencio on 01/10/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

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
