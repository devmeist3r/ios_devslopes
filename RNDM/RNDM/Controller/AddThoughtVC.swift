//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Lucas Inocencio on 27/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController {
    
    // Outlets
    @IBOutlet private weak var segmentCategory: UISegmentedControl!
    @IBOutlet private weak var tvThought: UITextView!
    @IBOutlet private weak var btPost: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    
    // Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btPost.layer.cornerRadius = 5
        tvThought.layer.cornerRadius = 5
        tvThought.text = "My random thought..."
        tvThought.textColor = UIColor.lightGray
        tvThought.delegate = self
        spinner.isHidden = true
    }
    
    @IBAction func categgoryChanged(_ sender: Any) {
        switch segmentCategory.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
        
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        
        guard let myThought = tvThought.text, tvThought.text != "" else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS: 0,
            NUM_LIKES: 0,
            THOUGHTS_TXT: myThought,
            TIMESTAMP: FieldValue.serverTimestamp(),
            USERNAME: Auth.auth().currentUser?.displayName ?? "",
            USER_ID: Auth.auth().currentUser?.uid ?? ""
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                
                self.navigationController?.popViewController(animated: true)
                
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            }
        }
    }
    
    
}

extension AddThoughtVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
}
