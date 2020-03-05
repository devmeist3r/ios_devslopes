//
//  MessageCell.swift
//  Smack
//
//  Created by Lucas Inocencio on 19/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var ivAvatarImg: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(message: Message) {
        lbMessage.text = message.message
        lbName.text = message.userName
        ivAvatarImg.image = UIImage(named: message.userAvatar)
        ivAvatarImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            lbTime.text = finalDate
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
