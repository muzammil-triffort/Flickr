//
//  HomeVC.swift
//  Polarr
//
//  Created by Muzammil Mohammad on 18/08/20.
//  Copyright © 2020 Turing. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MBProgressHUD

class HomeVC: UIViewController, AppSearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: AppSearchBar!
    @IBOutlet var toggleSwitch: UISwitch!

    var curatedArray: Array<Dictionary<String, Any>> = []
    
    var searchKey: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        self.title = NSLocalizedString("Flickr Search", comment: "")
        
        self.setupView()
    }
    
    func setupView() {
        
        self.toggleSwitch.isHidden = true
        self.toggleSwitch.isOn = false
        self.toggleSwitch.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        self.searchBar.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        
        self.collectionView.dataSource  = self
        self.collectionView.delegate    = self
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    @objc func toggleChanged() {
       
        self.collectionView.reloadData()
    }
    
    func appSearchViewSearchButtonTapped() {
        
        if self.searchKey != "" {
            self.loadCuratedList()
        }
    }
    
    func appSearchViewSearchText(searchText: NSString) {
        self.searchKey = searchText as String
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 1;
    }
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 1;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.curatedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.size.width, height: 85 - (view.safeAreaBottom/2.0) )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratedCell", for: indexPath as IndexPath) as UICollectionViewCell
    
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        let data: Dictionary = self.curatedArray[indexPath.row] as Dictionary

        let imageURL = APIConstants.filterImage(data: data)
        
        if let imageView = cell.viewWithTag(101) as? UIImageView {
            
            if self.toggleSwitch.isOn {
                
                imageView.sd_setImage(with: URL(string:imageURL), completed: { (image, error, type, url) in
                    
                    //Apply filter
                    imageView.image = image
                })
            }
            else
            {
                imageView.sd_setImage(with: URL(string: imageURL), placeholderImage:nil)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func loadCuratedList() {
               
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        APIManager.sharedInstance.getFlickerImages(searchText: self.searchKey, page: 1, onSuccess: { (feed) in

            DispatchQueue.main.async {
                
                let data = feed as Dictionary<String, Any>
                
                let photos = data[PHOTOS] as! Dictionary<String, Any>
                let photo = photos[PHOTO] as! Array< Dictionary<String, Any>>
                
                self.curatedArray = (photo as NSArray) as! Array<Dictionary<String, Any>>
                self.collectionView.reloadData()
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }

        }) { (Error) in
            
        }
    }
}
