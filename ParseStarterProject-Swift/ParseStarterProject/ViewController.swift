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



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ImageSelectedProtocol {
    
    
    var filterArray = ["CIPhotoEffectFade","CIPhotoEffectNoir","CISepiaTone","CIPhotoEffectChrome", "CIPhotoEffectProcess", "CIVignette",       "CIColorInvert"]
    var displayNameArray = ["Vintage", "Vintage", "B&W", "Chrome", "Chrome","Chrome",""]
    var filterImages = [UIImage]()
    var hasPickedImage = false
    let picker = UIImagePickerController()
        var selectedImage:UIImage!

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var leftFilterConstraint: NSLayoutConstraint!
    @IBOutlet weak var topButtonContstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadImageButton: ZFRippleButton!
    
    
    override func viewWillAppear(animated: Bool) {
        
        if let _ = selectedImage {
            self.imgView.image = selectedImage
        }
        
        if hasPickedImage == true {
            
                self.selectedImage = self.imgView.image!
                self.filterCollectionView.alpha = 1
                self.selectImageButton.alpha = 0
                self.leftFilterConstraint.constant = -20
                self.filterCollectionView.reloadData()
                self.uploadImageButton.alpha = 1
            
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uploadImageButton.alpha = 0
        
        let gallery = GalleryViewController()
        gallery.delegate = self
        
        picker.delegate = self
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        self.tabBarController!.tabBar.barTintColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "navIcon3.png"))
        
        let horizontalFlowLayout = CustomFlowLayout()
        horizontalFlowLayout.setupFilterCollectionView()
        self.filterCollectionView.collectionViewLayout = horizontalFlowLayout
        self.filterCollectionView.backgroundColor = UIColor.whiteColor()
        
        self.leftFilterConstraint.constant = 400
    
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func uploadPressed(sender: AnyObject) {
            
        if hasPickedImage == true {
            self.uploadImage(self.imgView.image)
        } else {
            self.displayImagelert()
        }
        
        
    }
    
    

    
    

    @IBAction func grabImagePressed(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            self.presentImagePicker(.PhotoLibrary)
        }
        

    }
    
    
    func rotate360Degrees(duration: CFTimeInterval = 0.4, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.imgView.layer.addAnimation(rotateAnimation, forKey: nil)
    }
    
    
    func presentActionSheet() {
        
        let action = UIAlertController(title: "", message: "Choose a source", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.presentImagePicker(.Camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        action.addAction(cameraAction)
        action.addAction(photoLibraryAction)
        action.addAction(cancelAction)
        
        
        self.presentViewController(action, animated: true, completion: nil)
        
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
        self.selectImageButton.alpha = 0
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.navigationBar
        
        print("did finish picking media")
        self.view.layoutIfNeeded()
        

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: UICollectionViewController Delegate
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filterArray.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("filterCell", forIndexPath: indexPath) as! FilterCollectionViewCell
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            FilterService.applyEffectToFilter(self.imgView.image!, filterString: self.self.filterArray[indexPath.row], displayString: self.displayNameArray[indexPath.row]) { (filteredImage, name) -> Void in
                
                self.filterImages.append(filteredImage!)
                cell.imageView.image = self.filterImages[indexPath.row]
                
            }
            
            
        }
        

        return cell
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            FilterService.applyEffectToFilter(self.selectedImage, filterString: self.filterArray[indexPath.row], displayString: self.displayNameArray[indexPath.row]) { (filteredImage, name) -> Void in
                self.imgView.image = filteredImage
            }
            
            
        }
        

        
    }

    
    
    
    //MARK: Image Selected Protocol
    func didSelectImage(image:UIImage) -> Void {
        
        self.imgView.image = image
        
    }
    
    
    
    
    
    
}