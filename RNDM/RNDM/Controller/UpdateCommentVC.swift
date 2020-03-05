//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by Lucas Inocencio on 01/10/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tfCommentTxt: UITextView!
    @IBOutlet weak var btUpdate: UIButton!
    
    // Variables
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        tfCommentTxt.text = commentData.comment.commentTxt
        //        print(commentData.comment.commentTxt)
    }
    
    func setUpView() {
        tfCommentTxt.layer.cornerRadius = 10
        btUpdate.layer.cornerRadius = 10
    }
    
    @IBAction func updateTouched(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId).collection(COMMENTS_REF).document(commentData.comment.documentId)
            .updateData([COMMENT_TXT: tfCommentTxt.text]) { (error) in
                if let error = error {
                    debugPrint("Unable to update comment: \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
