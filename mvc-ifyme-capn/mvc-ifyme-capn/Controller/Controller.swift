//
//  ViewController.swift
//  mvc-ifyme-capn
//
//  Created by Lucas Inocencio on 03/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class Controller: UIViewController {
    
    
    @IBOutlet weak var lbIphoneName: UILabel!
    @IBOutlet weak var lbIphoneColor: UILabel!
    @IBOutlet weak var lbIphonePrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appleProduct = AppleProduct(name: "iPhone X", color: "Space Gray", price: 999.99)
        
        lbIphoneName.text = appleProduct.name
        lbIphoneColor.text = appleProduct.color
        lbIphonePrice.text = "$ \(appleProduct.price)"
    }

}

