//
//  ImageCell.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/4/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    
    var image: ImageObject! {
        willSet(image){
            
            let url = URL(string: image.largeImageURL)!
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                self.displayImageView.image = UIImage(data: imageData)
            }
        }
    }
}
