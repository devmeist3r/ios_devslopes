//
//  Constants.swift
//  pixelCity
//
//  Created by Lucas Inocencio on 20/06/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import Foundation

let apiKey = "61790e678a132107e5ce2486c7128da9"
let apiSecret = "48caaaf272418ec5"

func flickUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
}
