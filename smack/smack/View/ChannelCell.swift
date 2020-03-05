//
//  ChannelCell.swift
//  Smack
//
//  Created by Lucas Inocencio on 14/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var lbChannelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        lbChannelName.text = "#\(title)"
        lbChannelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                lbChannelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
        
    }

}
