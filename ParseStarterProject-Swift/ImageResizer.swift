//
//  ImageResizer.swift
//  SortaGram
//
//  Created by HoodsDream on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit



class ImageResizer {
    
    class func resizeImage(image : UIImage, size : CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    //dfjsfadfasdf
    
    
}
