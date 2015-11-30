//
//  GalleryViewController.swift
//  SortaGram
//
//  Created by HoodsDream on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!

    var posts = [PFObject]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Post")
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
    
                    if data != nil{
                        let image = UIImage(data:data!)
                        cell.imageView.image = image
                    }
            }
            
        }
        
        return cell
        
    }
    




    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(100.0, 100.0)
        
    }

}
