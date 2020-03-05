//
//  CommentCell.swift
//  RNDM
//
//  Created by Lucas Inocencio on 29/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
    func commentOptionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbTimestamp: UILabel!
    @IBOutlet weak var lbComments: UILabel!
    @IBOutlet weak var ivOptions: UIImageView!
    
    // Variables
    private var comment: Comment!
    private var delegate: CommentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(comment: Comment, delegate: CommentDelegate?) {
        
        self.comment = comment
        self.delegate = delegate
        
        ivOptions.isHidden = true
        lbUsername.text = comment.username
        lbComments.text = comment.commentTxt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        lbTimestamp.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            ivOptions.isHidden = false
            ivOptions.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentOptionsTapped))
            ivOptions.addGestureRecognizer(tap)
        }
    }
    
    @objc func commentOptionsTapped() {
        delegate?.commentOptionsTapped(comment: comment)
    }

}
