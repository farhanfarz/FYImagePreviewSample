//
//  FYImageViewController.swift
//  FYImagePreviewSample
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit
import JTSImageViewController

class FYImageViewController: UIViewController {

    /////////////////////////////////////////////////////////////
    //
    // MARK: Variables
    //
    /////////////////////////////////////////////////////////////
    
    @IBOutlet weak var imageView: FYPreviewImageView!
    
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: View Life Cycles
    //
    /////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.descriptionTitle = "This is a test description"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
