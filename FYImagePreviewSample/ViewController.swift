//
//  ViewController.swift
//  FYImagePreviewSample
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit
import NYTPhotoViewer

class ViewController: UIViewController {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: Variables
    //
    /////////////////////////////////////////////////////////////
    
    @IBOutlet weak var imageButton : UIButton?
    private let photos = PhotosProvider().photos
    
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: - View Life Cycles
    //
    /////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonImage = UIImage(named: PrimaryImageName)
        imageButton?.setBackgroundImage(buttonImage, forState: .Normal)
    }
}

extension ViewController {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: - Actions
    //
    /////////////////////////////////////////////////////////////
    
    @IBAction func buttonTapped(sender: UIButton) {
        let photosViewController = NYTPhotosViewController(photos: self.photos)
        photosViewController.delegate = self
        presentViewController(photosViewController, animated: true, completion: nil)
        
        updateImagesOnPhotosViewController(photosViewController, afterDelayWithPhotos: photos)
    }
}

extension ViewController {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: - Methods
    //
    /////////////////////////////////////////////////////////////
    
    func updateImagesOnPhotosViewController(photosViewController: NYTPhotosViewController, afterDelayWithPhotos: [ExamplePhoto]) {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, 5 * Int64(NSEC_PER_SEC))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            for photo in self.photos {
                if photo.image == nil {
                    photo.image = UIImage(named: PrimaryImageName)
                    photosViewController.updateImageForPhoto(photo)
                }
            }
        }
    }
}

extension ViewController: NYTPhotosViewControllerDelegate {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: - NYTPhotosViewControllerDelegate
    //
    /////////////////////////////////////////////////////////////
    
    func photosViewController(photosViewController: NYTPhotosViewController, handleActionButtonTappedForPhoto photo: NYTPhoto) -> Bool {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            guard let photoImage = photo.image else { return false }
            
            let shareActivityViewController = UIActivityViewController(activityItems: [photoImage], applicationActivities: nil)
            
            shareActivityViewController.completionWithItemsHandler = {(activityType: String?, completed: Bool, items: [AnyObject]?, error: NSError?) in
                if completed {
                    photosViewController.delegate?.photosViewController!(photosViewController, actionCompletedWithActivityType: activityType!)
                }
            }
            
            shareActivityViewController.popoverPresentationController?.barButtonItem = photosViewController.rightBarButtonItem
            photosViewController.presentViewController(shareActivityViewController, animated: true, completion: nil)
            
            return true
        }
        
        return false
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, referenceViewForPhoto photo: NYTPhoto) -> UIView? {
        if photo as? ExamplePhoto == photos[NoReferenceViewPhotoIndex] {
            return nil
        }
        return imageButton
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, loadingViewForPhoto photo: NYTPhoto) -> UIView? {
        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
            let label = UILabel()
            label.text = "Custom Loading..."
            label.textColor = UIColor.greenColor()
            return label
        }
        return nil
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, captionViewForPhoto photo: NYTPhoto) -> UIView? {
        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
            let captionView = UIView(frame: CGRectMake(0, 0, 320, 44))
            let label = UILabel(frame: CGRectMake(0, 0, 320, 44))
            label.numberOfLines = 0
            label.text = "photo with long caption. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum maximus laoreet vehicula. Maecenas elit quam, pellentesque at tempor vel, tempus non sem. Vestibulum ut aliquam elit. Vivamus rhoncus sapien turpis, at feugiat augue luctus id. Nulla mi urna, viverra sed augue malesuada, bibendum bibendum massa. Cras urna nibh, lacinia vitae feugiat eu, consectetur a tellus. Morbi venenatis nunc sit amet varius pretium. Duis eget sem nec nulla lobortis finibus. Nullam pulvinar gravida est eget tristique. Curabitur faucibus nisl eu diam ullamcorper, at pharetra eros dictum. Suspendisse nibh urna, ultrices a augue a, euismod mattis felis. Ut varius tortor ac efficitur pellentesque. Mauris sit amet rhoncus dolor. Proin vel porttitor mi. Pellentesque lobortis interdum turpis, vitae tincidunt purus vestibulum vel. Phasellus tincidunt vel mi sit amet congue."
            label.textColor = UIColor.whiteColor()
            label.backgroundColor = UIColor.clearColor()
            captionView.addSubview(label)
            
            return captionView
        }
        return nil
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, didNavigateToPhoto photo: NYTPhoto, atIndex photoIndex: UInt) {
        print("Did Navigate To Photo: \(photo) identifier: \(photoIndex)")
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, actionCompletedWithActivityType activityType: String?) {
        print("Action Completed With Activity Type: \(activityType)")
    }
    
    func photosViewControllerDidDismiss(photosViewController: NYTPhotosViewController) {
        print("Did dismiss Photo Viewer: \(photosViewController)")
    }
}

