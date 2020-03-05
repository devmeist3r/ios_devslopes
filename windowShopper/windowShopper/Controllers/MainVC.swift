//
//  ViewController.swift
//  windowShopper
//
//  Created by Lucas Inocencio on 06/04/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var txWage: CurrencyTxtField!
    @IBOutlet weak var txPrice: CurrencyTxtField!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbHours: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calcBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        calcBtn.backgroundColor = #colorLiteral(red: 1, green: 0.6190719604, blue: 0, alpha: 1)
        calcBtn.setTitle("Calculate", for: .normal)
        calcBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        calcBtn.addTarget(self, action: #selector(MainVC.calculate), for: .touchUpInside)
        txWage.inputAccessoryView = calcBtn
        txPrice.inputAccessoryView = calcBtn
        lbResult.isHidden = true
        lbHours.isHidden = true
    }
    
    @objc func calculate () {
        if let txWage = txWage.text, let txPrice = txPrice.text {
            if let wage = Double(txWage), let price = Double(txPrice) {
                view.endEditing(true)
                lbResult.isHidden = false
                lbHours.isHidden = false
                lbResult.text = "\(Wage.getHours(forWage: wage, andPrice: price))"
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearCalculatePressed(_ sender: Any) {
        lbResult.isHidden = true
        lbHours.isHidden = true
        txWage.text = ""
        txPrice.text = ""
    }
    

}

