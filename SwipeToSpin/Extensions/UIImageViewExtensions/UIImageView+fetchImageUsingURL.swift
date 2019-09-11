//
//  UIImageView+fetchImageUsingURL.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/5/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL) {
        
        contentMode = UIView.ContentMode.scaleAspectFill
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            
            DispatchQueue.main.async() {
                self.image = image
            }
            
        }.resume()
    }
    
    func setImage(from link: String) {
        guard let url = URL(string: link) else { return }
        downloadImage(from: url)
    }
    
}
