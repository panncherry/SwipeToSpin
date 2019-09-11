//
//  UIViewController+CustomNavigation.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/5/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func customNavigation() {
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        logoImageView.contentMode = .scaleAspectFit
        let logo = UIImage(named: "logo.png")
        logoImageView.image = logo
        navigationItem.titleView = logoImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let resetButton = UIButton(type: .custom)
        resetButton.setTitle("reset", for: .normal)
        resetButton.tintColor = UIColor(red: 0.00, green: 0.36, blue: 0.59, alpha: 1.0)
        resetButton.setTitleColor(resetButton.tintColor, for: .normal)
        resetButton.addTarget(self, action: #selector(self.resetAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: resetButton)
        
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "search.png"), for: .normal)
        searchButton.setTitle("", for: .normal)
        searchButton.setTitleColor(searchButton.tintColor, for: .normal)
        searchButton.addTarget(self, action: #selector(self.searchAction(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        
    }
    
    
    // MARK: IBAction - Search
    @IBAction func searchAction(_ sender: UIButton) {
        requestSearchParametersAlert()
    }
    
    
    // MARK: IBAction - Clear serach
    @IBAction func resetAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name.loadDefaultImages, object: nil)
    }
}
