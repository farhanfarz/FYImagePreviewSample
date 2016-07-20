//
//  AKMediaFocusBasicToolbarController.swift
//  AKMediaViewer
//
//  Created by Diogo Autilio on 3/23/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import Foundation
import UIKit

public class AKMediaFocusBasicToolbarController : UIViewController {
    
    @IBOutlet var doneButton: UIButton!
    
    
    public override func viewDidLoad() {
        
        doneButton.setTitle(NSLocalizedString("Done", comment: "Done"), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        doneButton.backgroundColor =  UIColor.init(white: 0, alpha: 0.5)
        doneButton.sizeToFit()
        
        doneButton.frame = CGRectInset(self.doneButton.frame, -20, -4)
        doneButton.layer.borderWidth = 2
        doneButton.layer.cornerRadius = 4
        doneButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
}
