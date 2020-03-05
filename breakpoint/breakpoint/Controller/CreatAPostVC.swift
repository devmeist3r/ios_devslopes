//
//  CreatAPostVC.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 28/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreatAPostVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var tfMessage: UITextView!
    @IBOutlet weak var btSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfMessage.delegate = self
        btSend.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lbEmail.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        if tfMessage.text != nil && tfMessage.text != "Say something here..." {
            btSend.isEnabled = false
            DataService.instance.uploadPost(withMessage: tfMessage.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.btSend.isEnabled = false
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.btSend.isEnabled = true
                    print("There was an error!!")
                }
            }
        }
    }
    
}

extension CreatAPostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        tfMessage.text = ""
    }
}

