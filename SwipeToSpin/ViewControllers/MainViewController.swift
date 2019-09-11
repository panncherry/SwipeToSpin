//
//  ViewController.swift
//  SwipeToSpin
//
//  Created by Pann Cherry on 9/4/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import UIKit

// MARK: Global variable
var userInputNumber: Int = 0

class MainViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: Properties
    var refreshControl = UIRefreshControl()
    private let cellId = "ImageCell"
    var images: [ImageObject] = []
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.dataSource = self
        customNavigation()
        flowLayoutSetup()
        notificationObservers()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDefaultImages()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        self.activityIndicator.startAnimating()
    }
    
    
    // MARK: Helper functions for navigation bar button items
    @objc func loadCustomSearchImages(notification: NSNotification) {
        fetchCustomSearchImages()
    }
    
    
    @objc func loadDefaultImages(notification: NSNotification) {
        fetchDefaultImages()
    }
    
    
    // MARK: Fetch default images
    func fetchDefaultImages() {
        
        APIManager().fetchImagesByDefault{ (images: [ImageObject]?, error: Error?) in
            if let images = images {
                self.images = images
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    
    // MARK: Fetch images according to user input
    func fetchCustomSearchImages() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            APIManager().fetchImagesByUserInput { (images: [ImageObject]?, error: Error?) in
                if let images = images {
                    self.images = images
                    if images.count == 0 {
                        self.displayAlert(title: "SORRY", message: "No Image found. Please try again.")
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        
    }
    
    
    // MARK: Check input value is a prime or not
    func isPrime(input: Int) -> Bool {
        
        guard input >= 2 else { return false }
        
        for i in 2 ..< input {
            if input % i == 0 {
                print("The number user entered is not a prime number.")
                return false
            }
        }
        
        userInputNumber = input
        print("The prime number that user entered is \(userInputNumber)")
        return true
    }
    
    
    // MARK: CollectionView Flow Layout
    func flowLayoutSetup(){
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 10 //The minimum spacing to use between items in the same row.
        layout.minimumLineSpacing = layout.minimumInteritemSpacing //The minimum spacing to use between lines of items in the grid.
        
        let cellPerLine: CGFloat = 3
        let width = self.collectionView.frame.size.width/cellPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        
    }
    
    
    // MARK: Refresh the screen
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchDefaultImages()
    }
    
    
    // MARK: Notification Observers
    func notificationObservers() {
        
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.loadCustomSearchImages(notification:)), name: NSNotification.Name.loadCustomSearchImages, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.loadDefaultImages(notification:)), name: NSNotification.Name.loadDefaultImages, object: nil)
        }
    }
    
}



// MARK: UICollectionView DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        
        let image = images[indexPath.item]
        
        cell.displayImageView.setImage(from: image.largeImageURL)
        
        return cell
    }
    
}
