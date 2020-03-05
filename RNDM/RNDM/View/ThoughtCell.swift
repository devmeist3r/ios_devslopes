//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Lucas Inocencio on 27/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

protocol ThoughtDelegate {
    func thoughtOptionsTapped(thought: Thought)
}

class ThoughtCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbTimestamp: UILabel!
    @IBOutlet weak var lbThoutsTxt: UILabel!
    @IBOutlet weak var ivLikes: UIImageView!
    @IBOutlet weak var lbLikesNum: UILabel!
    @IBOutlet weak var ivComments: UIImageView!
    @IBOutlet weak var lbCommentsLikes: UILabel!
    @IBOutlet weak var ivOptionsMenu: UIImageView!
    
    
    // Variables
    private var thought: Thought!
    private var delegate: ThoughtDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        ivLikes.addGestureRecognizer(tap)
        ivLikes.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
//        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).setData([NUM_LIKES : thought.numLikes + 1], merge: true)
        
        Firestore.firestore().document("thoughts/\(thought.documentId!)").updateData([NUM_LIKES: thought.numLikes + 1])
    }
    
    func configureCell(thought: Thought, delegate: ThoughtDelegate?) {
        ivOptionsMenu.isHidden = true
        self.thought = thought
        self.delegate = delegate
        lbUsername.text = thought.username
        lbThoutsTxt.text = thought.thoughtTxt
        lbLikesNum.text = String(thought.numLikes)
        lbCommentsLikes.text = String(thought.numComments)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        lbTimestamp.text = timestamp
        
        if thought.userId == Auth.auth().currentUser?.uid {
            ivOptionsMenu.isHidden = false
            ivOptionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionsTapped))
            ivOptionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func thoughtOptionsTapped() {
        delegate?.thoughtOptionsTapped(thought: thought)
    }

}
