//
//  UIAlert+displayAlert.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/5/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import Foundation
import UIKit

// MAKR: Global variable
var imageName: String = ""


extension UIViewController {
    
    // MARK: UIAlerts
    func requestSearchParametersAlert() {
        
        let alert = UIAlertController(title: "Search Image", message: "Enter image description and a number.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "dogs, cat, love, etc."
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter a prime number greater than 1."
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            if alert?.textFields![0].text == "" && alert?.textFields![1].text == "" {
                self.displayAlert(title: "Invalid Input", message: "Both image name and a prime number is required.")
            }
            
            if let textField1 = alert?.textFields![0] {
                
                if textField1.text == "" {
                    
                    self.displayAlert(title: "Invalid Input", message: "Image name is required.")
                    
                } else {
                    
                    imageName = textField1.text!
                    print("The image name that user entered is \(imageName )")
                }
            }
            
            
            if let textField2 = alert?.textFields![1] {
                
                if textField2.text == "" {
                    
                    self.displayAlert(title: "Invalid Input", message: "A prime number is required.")
                } else {
                    
                    let number = Int(textField2.text!)
                    
                    if number != nil {
                        
                        let vc = MainViewController()
                        
                        if number! <= 1 {
                            self.displayAlert(title: "Invalid Input", message: "A prime number greater than 1 is required.")
                        }
                        
                        if number! > 200 {
                            self.displayAlert(title: "Invalid Input", message: "A prime number greater than 1 and smaller than 200 is required.")
                        }
                        
                        if !vc.isPrime(input: number!) {
                            
                            self.displayAlert(title: "Not Prime", message: "Please enter a prime number.")
                            
                        } else {
                            
                            NotificationCenter.default.post(name: NSNotification.Name.loadCustomSearchImages, object: nil)
                        }
                    } else {
                        
                        self.displayAlert(title: "Invalid Input", message: "Only prime number is allowed.")
                    }
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: UIAlert Helper Function
    func displayAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            
            NotificationCenter.default.post(name: NSNotification.Name.loadDefaultImages, object: nil)
            
            self.requestSearchParametersAlert()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
