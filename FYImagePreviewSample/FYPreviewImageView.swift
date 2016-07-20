//
//  FYPreviewImageView.swift
//  FYImagePreviewSample
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit
import JTSImageViewController

class FYPreviewImageView: UIImageView {

    /////////////////////////////////////////////////////////////
    //
    // MARK: Variables
    //
    /////////////////////////////////////////////////////////////
    
    var descriptionTitle: String?
    
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: Initialization
    //
    /////////////////////////////////////////////////////////////
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userInteractionEnabled = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTapGesture()
    }
}

extension FYPreviewImageView {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: Methods
    //
    /////////////////////////////////////////////////////////////
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FYPreviewImageView.didTapImageView(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func didTapImageView(recognizer:UITapGestureRecognizer) {
        
        let imageInfo = JTSImageInfo()
        imageInfo.title = descriptionTitle
        imageInfo.altText = descriptionTitle
        imageInfo.image = self.image
        imageInfo.referenceRect = self.frame
        imageInfo.referenceView = self.superview
        let imageController = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.Image, backgroundStyle: JTSImageViewControllerBackgroundOptions.Blurred)
        imageController.showFromViewController(UIApplication.sharedApplication().keyWindow?.rootViewController, transition: .FromOriginalPosition)
        
    }
}