//
//  Category.swift
//  coderSwag
//
//  Created by Lucas Inocencio on 07/04/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import Foundation

struct Category {
    private(set) public var title: String!
    private(set) public var imageName: String!
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
