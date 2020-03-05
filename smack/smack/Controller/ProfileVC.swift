//
//  ProfileVC.swift
//  Smack
//
//  Created by Lucas Inocencio on 14/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ivProfile: CircleImage!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        lbName.text = UserDataService.instance.name
        lbEmail.text = UserDataService.instance.email
        ivProfile.image = UIImage(named: UserDataService.instance.avatarName)
        ivProfile.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
