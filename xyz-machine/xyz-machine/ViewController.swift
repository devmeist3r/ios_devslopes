//
//  ViewController.swift
//  xyz-machine
//
//  Created by Lucas Inocencio on 08/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var lbX: UILabel!
    @IBOutlet weak var lbY: UILabel!
    @IBOutlet weak var lbZ: UILabel!
    
    var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates(to: .main, withHandler: updateLabels(data:error:))
    }
    
    func updateLabels(data: CMAccelerometerData?, error: Error?) {
        guard let accelerometerData = data else { return }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        let x = formatter.string(for: accelerometerData.acceleration.x)
        let y = formatter.string(for: accelerometerData.acceleration.y)
        let z = formatter.string(for: accelerometerData.acceleration.z)
        
        
        lbX.text = "X: \(x)"
        lbY.text = "Y: \(y)"
        lbZ.text = "Z: \(z)"
    }
    
    
}

