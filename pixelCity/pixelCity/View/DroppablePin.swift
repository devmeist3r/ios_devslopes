//
//  DroppablePin.swift
//  pixelCity
//
//  Created by Lucas Inocencio on 20/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}
