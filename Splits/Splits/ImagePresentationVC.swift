//
//  ImagePresentationVC.swift
//  Splits
//
//  Created by Lucas Inocencio on 10/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class ImagePresentationVC: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImageView.image = image
    }
}
