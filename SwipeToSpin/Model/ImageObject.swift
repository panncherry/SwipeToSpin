//
//  Image.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/4/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import Foundation

class ImageObject {
    
    var largeImageURL: String
    var id: NSNumber
    
    init(dictionary: [String: Any]) {
        largeImageURL = dictionary["largeImageURL"] as? String ?? "Invalid Url"
        id = dictionary["id"] as! NSNumber
    }
    
    
    class func images(dictionaries: [[String: Any]]) -> [ImageObject] {
        var images: [ImageObject] = []
        for dictionary in dictionaries {
            let image = ImageObject(dictionary: dictionary)
            images.append(image)
        }
        return images
    }
}
