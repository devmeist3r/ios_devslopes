//
//  ParallaxCell.swift
//  accelerometron
//
//  Created by Lucas Inocencio on 10/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class ParallaxCell: UITableViewCell {
    
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withImage image: UIImage, andDescription desc: String) {
        ivImage.image = image
        lbDescription.text = desc
    }

    func setupParallax() {
        let min = CGFloat(-30)
        let max = CGFloat(30)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type:.tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion, yMotion]
        
        ivImage.addMotionEffect(motionEffectGroup)
    }

}
