//
//  APIManager.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/4/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import Foundation
import UIKit


class APIManager {
   
    // MARK: Properties
    static let imageUrlString = "https://pixabay.com/api/?key=\(APIKey.apiKey)&image_type=\(Parameters.image_type)&per_page=\(Parameters.per_page)&page=3"
    
    var session: URLSession

    
    // MARK: URLSession initialization
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    
    // MARK: Fetch default images
    func fetchImagesByDefault(completion: @escaping ([ImageObject]?, Error?) -> ()) {
        
        print(APIManager.imageUrlString)
        
        let url = URL(string: APIManager.imageUrlString)!

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        let task = session.dataTask(with: request) { (data, response, error) in

            if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let imageDictionaries = dataDictionary["hits"] as! [[String: Any]]
                let images = ImageObject.images(dictionaries: imageDictionaries)
                completion(images, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
    // MARK: Fetch images according to user input
    func fetchImagesByUserInput(completion: @escaping ([ImageObject]?, Error?) -> ()) {
        
        let parseImageName = imageName.lowercased().replacingOccurrences(of: " +", with: "+", options: .regularExpression, range: nil)
        
        var imageUrlSearchString: String = ""
        
        if parseImageName == "" {
            
            NotificationCenter.default.post(name: NSNotification.Name.loadDefaultImages, object: nil)

            imageUrlSearchString = "https://pixabay.com/api/?key=\(APIKey.apiKey)&image_type=\(Parameters.image_type)&per_page=\(Parameters.per_page)&page=3"
        } else {
            
            imageUrlSearchString = "https://pixabay.com/api/?key=\(APIKey.apiKey)&q=\(parseImageName)&image_type=\(Parameters.image_type)&per_page=\(userInputNumber)"
        }
        
       
        print(imageUrlSearchString)
        
        let url = URL(string: imageUrlSearchString)!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let imageDictionaries = dataDictionary["hits"] as! [[String: Any]]
                let images = ImageObject.images(dictionaries: imageDictionaries)
                completion(images, nil)
                
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }

}
