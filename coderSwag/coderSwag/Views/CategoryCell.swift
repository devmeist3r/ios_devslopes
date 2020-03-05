//
//  CategoryCell.swift
//  coderSwag
//
//  Created by Lucas Inocencio on 07/04/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    func updateViews(category: Category) {
        categoryImage.image = UIImage(named: category.imageName)
        categoryTitle.text = category.title
    }

}
