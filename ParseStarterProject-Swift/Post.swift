//
//  Post.swift
//  SortaGram
//
//  Created by HoodsDream on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit
import Parse



class Post {
    
    var post = PFObject(className: "Post")
    var imageToUpload: UIImage

    
    
    init(image:UIImage) {
        
        let smallerImage = ImageResizer.resizeImage(image, size: CGSize(width: 600.0, height: 600.0))
        
        self.imageToUpload = smallerImage
        print(smallerImage.size)
        
        if let imageData = UIImagePNGRepresentation(image) {
            let imageFile = PFFile(name: "image.png", data: imageData)
            post["imageFile"] = imageFile
        }

    }
    

    func save()  {
        post.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                print("good job!")
            } else {
                print("you know you fcked up right?")
            }
            
        })
    
    }
    
    

    
}





