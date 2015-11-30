/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    var hasPickedImage = false
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func selectFilterPressed(sender: AnyObject) {
        
        self.presentFilterActionSheet()
        
    }
    

    @IBAction func grabImagePressed(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            self.presentImagePicker(.PhotoLibrary)
        }

    }
    
    
    func presentActionSheet() {
        
        let action = UIAlertController(title: "", message: "Choose a source", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.presentImagePicker(.Camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        
        let upload = UIAlertAction(title: "Upload to parse", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.uploadToParse()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        action.addAction(cameraAction)
        action.addAction(photoLibraryAction)
        action.addAction(upload)
        action.addAction(cancelAction)
        
        
        self.presentViewController(action, animated: true, completion: nil)
        
    }
    
    func presentFilterActionSheet() {
        
        let alertController = UIAlertController(title: "Filters", message: "Choose a Filter", preferredStyle: .ActionSheet)
        
        let filterVintage = UIAlertAction(title: "Vintage", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyVintageEffect(self.imgView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage {
                    self.imgView.image = filteredImage
                    print("Vintage Filter Applied")
                }
            })
        }
        
        let filterBW = UIAlertAction(title: "Black and White", style: UIAlertActionStyle.Default) { (alert) -> Void in
            print("BW Filter Applied")
            FilterService.applyBWEffect(self.imgView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage {
                    self.imgView.image = filteredImage
                    print("Black and White Filter Applied")
                }
            })
        }
        
        let filterChrome = UIAlertAction(title: "Chrome", style: UIAlertActionStyle.Default) { (alert) -> Void in
            print("Chrome Filter Applied")
            FilterService.applyChromeEffect(self.imgView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage {
                    self.imgView.image = filteredImage
                    print("Chrome Filter Applied")
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(filterVintage)
        alertController.addAction(filterBW)
        alertController.addAction(filterChrome)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    

    
    
    
    func uploadToParse() {
        
        if hasPickedImage == true {
            self.uploadImage(self.imgView.image)
        } else {
            self.displayImagelert()
        }

    }
    
    
    func uploadImage(image:UIImage?) {
        
        let post = Post(image: image!)
        post.save()
        
        
    }
    
    
    func displaySuccessAlert() {
        
        let action = UIAlertController (title: "Success", message: "Image was uploaded", preferredStyle: UIAlertControllerStyle.Alert)
        
        action.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(action, animated: true, completion: nil)
        
    }
    
    
    func displayErrorAlert() {
        
        let action = UIAlertController (title: "Uh-oh", message: "Image was not uploaded", preferredStyle: UIAlertControllerStyle.Alert)
        
        action.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(action, animated: true, completion: nil)
        
    }
    
    
    func displayImagelert() {
        
        let action = UIAlertController (title: "Uh-oh", message: "You must first choose an image", preferredStyle: UIAlertControllerStyle.Alert)
        
        action.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(action, animated: true, completion: nil)

        
    }
    
    
    func presentImagePicker(sourceTpye: UIImagePickerControllerSourceType) {
        picker.delegate = self
        picker.sourceType = sourceTpye
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imgView.image = image
        self.hasPickedImage = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
}