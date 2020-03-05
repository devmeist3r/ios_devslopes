//
//  NewGroupVC.swift
//  breakpoint
//
//  Created by Lucas Inocencio on 29/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateGroupVC: UIViewController {

    // Outlets
    @IBOutlet weak var tfTitle: InsertTextField!
    @IBOutlet weak var tfDescription: InsertTextField!
    @IBOutlet weak var tfAddPeople: InsertTextField!
    @IBOutlet weak var btDone: UIButton!
    @IBOutlet weak var lbGroupMember: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfAddPeople.delegate = self
        tfAddPeople.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btDone.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        if tfAddPeople.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: tfAddPeople.text!) { (returnEmailArray) in
                self.emailArray = returnEmailArray
                self.tableView.reloadData()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        if tfTitle.text != "" && tfDescription.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(withTitle: self.tfTitle.text!, andDescription: self.tfDescription.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group could not be created. Please try again")
                    }
                })
            }
        }
    }
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserCell else { return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
             cell.confoigureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
             cell.confoigureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.lbEmail.text!) {
            chosenUserArray.append(cell.lbEmail.text!)
            lbGroupMember.text = chosenUserArray.joined(separator: ", ")
            btDone.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.lbEmail.text! })
            if chosenUserArray.count >= 1 {
                lbGroupMember.text = chosenUserArray.joined(separator: ", ")
            } else {
                lbGroupMember.text = "add people to your group"
                btDone.isHidden = true
            }
        }
    }
    
}

extension CreateGroupVC: UITextFieldDelegate {
    
}

