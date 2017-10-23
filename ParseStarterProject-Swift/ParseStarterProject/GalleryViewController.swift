//
//  GalleryViewController.swift
//  SortaGram
//
//  Created by HoodsDream on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import Foundation


protocol ImageSelectedProtocol {
    func didSelectImage(selectedImage: UIImage) -> Void
}

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!

    
    var posts = [PFObject]()
    var delegate : ImageSelectedProtocol?
    var images = [UIImage()]
    
    
    
    override func viewWillAppear(animated: Bool) {
        
            self.collectionView.reloadData()
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.view.backgroundColor = UIColor(red: 63/255, green: 63/255, blue: 81/255, alpha: 1.0)
        self.tabBarController!.tabBar.tintColor = UIColor.whiteColor()
        
        self.collectionView.backgroundColor = UIColor.whiteColor()
        
        let mainFlowLayout = CustomFlowLayout()
        mainFlowLayout.setupMainCollectionView()
        self.collectionView.collectionViewLayout = mainFlowLayout
        
        let query = PFQuery(className:"Post")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    self.posts.append(object)
                }
                
            } else {
                
                //just chill
                
            }
            
            print(self.posts.count)
            self.collectionView.reloadData()
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    // MARK: UICollectionView

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        
        let post = self.posts[indexPath.row]
        if let imageFile = post["imageFile"] as? PFFile {
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                
                if let image = UIImage(data:data!) {
                    self.images.insert(image, atIndex:indexPath.row)
                    cell.imageView.image = image
                }
                
            }
            
        }
        
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        self.delegate?.didSelectImage(self.images[indexPath.row])
        
        self.tabBarController?.selectedIndex = 0
        
        
        
    }
    

    

}
