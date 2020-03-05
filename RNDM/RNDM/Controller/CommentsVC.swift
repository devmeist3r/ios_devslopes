//
//  CommentsVC.swift
//  RNDM
//
//  Created by Lucas Inocencio on 29/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfComment: UITextField!
    @IBOutlet weak var btSend: UIButton!
    @IBOutlet weak var keyboardView: UIView!
    
    // Variables
    var thought: Thought!
    var comments = [Comment]()
    var thoughtRef: DocumentReference!
    var firestore = Firestore.firestore()
    var username: String!
    var commentListener: ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        thoughtRef = firestore.collection(THOUGHTS_REF).document(thought.documentId)
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
        
        setUpView()
        
        self.view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CommentsVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        commentListener = firestore.collection(THOUGHTS_REF).document(self.thought.documentId)
            .collection(COMMENTS_REF)
            .order(by: TIMESTAMP, descending: false)
            .addSnapshotListener({ (snapshot, error) in
                
                guard let snapshot = snapshot else {
                    debugPrint("Error fetching comments: \(error)")
                    return
                }
                
                self.comments.removeAll()
                self.comments = Comment.parseData(snapshot: snapshot)
                self.tableView.reloadData()
            })
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        commentListener.remove()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func setUpView() {
        tfComment.layer.cornerRadius = 10
        tfComment.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tfComment.layer.borderWidth = 0.5
        tfComment.addPadding(.left(10))
        tfComment.addPadding(.right(10))
    }
    

    @IBAction func sendPressed(_ sender: Any) {
        guard let commentTxt = tfComment.text, tfComment.text != "" else { return }
        
        firestore.runTransaction({ (transiction, errorPointer) -> Any? in
            
            let thoughtDocument: DocumentSnapshot
            
            do {
                try thoughtDocument = transiction.getDocument(Firestore.firestore()
                    .collection(THOUGHTS_REF).document(self.thought.documentId))
            } catch let error as NSError {
                debugPrint("Fetch error: \(error.localizedDescription)")
                return nil
            }
            
            guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else { return nil }
            
            transiction.updateData([NUM_COMMENTS : oldNumComments + 1], forDocument: self.thoughtRef)
            
            let newCommentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document()
            
            transiction.setData([
                COMMENT_TXT : commentTxt,
                TIMESTAMP: FieldValue.serverTimestamp(),
                USERNAME: self.username,
                USER_ID: Auth.auth().currentUser?.uid ?? ""
                ], forDocument:  newCommentRef)
            
            return nil
            
        }) { (object, error) in
            if let error = error {
                debugPrint("Transiction failed: \(error)")
            } else {
                self.tfComment.text = ""
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UpdateCommentVC {
            if let commentData = sender as? (comment: Comment, thought: Thought) {
                destination.commentData = commentData
            }
        }
    }
    
}

extension CommentsVC: CommentDelegate {
    func commentOptionsTapped(comment: Comment) {
        // adding alert
        let alert = UIAlertController(title: "Edit Comment", message: "You can delete or edit", preferredStyle: .actionSheet)

        let editAction = UIAlertAction(title: "Edit Comment", style: .default) { (action) in
            // Edit
            self.performSegue(withIdentifier: "toEditComment", sender: (comment, self.thought))
            alert.dismiss(animated: true, completion: nil)
        }
        
        let deleteAction = UIAlertAction(title: "Delete Comment", style: .default) { (action) in
            // Delete
            
            self.firestore.runTransaction({ (transiction, errorPointer) -> Any? in
                
                let thoughtDocument: DocumentSnapshot
                
                do {
                    try thoughtDocument = transiction.getDocument(Firestore.firestore()
                        .collection(THOUGHTS_REF).document(self.thought.documentId))
                } catch let error as NSError {
                    debugPrint("Fetch error: \(error.localizedDescription)")
                    return nil
                }
                
                guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else { return nil }
                
                transiction.updateData([NUM_COMMENTS : oldNumComments - 1], forDocument: self.thoughtRef)
                
                let commentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document(comment.documentId)
                
                transiction.deleteDocument(commentRef)
                
                return nil
                
            }) { (object, error) in
                if let error = error {
                    debugPrint("Transiction failed: \(error)")
                } else {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension CommentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CommentCell {
            cell.configureCell(comment: comments[indexPath.row], delegate: self)
            return cell
        }
        
        return UITableViewCell()
    }
}
