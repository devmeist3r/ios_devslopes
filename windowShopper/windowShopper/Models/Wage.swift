//
//  Wage.swift
//  windowShopper
//
//  Created by Lucas Inocencio on 06/04/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import Foundation

class Wage {
    class func  getHours(forWage wage: Double, andPrice price: Double) -> Int {
        return Int(ceil(price / wage))
    }
}
