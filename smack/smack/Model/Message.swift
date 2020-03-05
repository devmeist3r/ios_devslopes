//
//  Message.swift
//  Smack
//
//  Created by Lucas Inocencio on 19/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import Foundation

struct Message: Decodable {
    public private(set) var message: String!
    public private(set) var userName: String!
    public private(set) var channelId: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColor: String!
    public private(set) var id: String!
    public private(set) var timeStamp: String!
}
