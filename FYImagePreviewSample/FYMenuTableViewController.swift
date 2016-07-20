//
//  FYMenuTableViewController.swift
//  FYImagePreviewSample
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit
import MWPhotoBrowser

class FYMenuTableViewController: UITableViewController {

    /////////////////////////////////////////////////////////////
    //
    // MARK: Variables
    //
    /////////////////////////////////////////////////////////////
    
    let arrayFeatures:[[String:String]] = [["title":"Single Image","subtitle":"with caption, no grid button"]]
    var arrayPhotos:[MWPhoto] = []
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: View Life Cycles
    //
    /////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FYMenuTableViewController {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: Actions
    //
    /////////////////////////////////////////////////////////////
    
    @IBAction func didChangeSegment(sender: UISegmentedControl) {
    
    }
}

extension FYMenuTableViewController {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: - Table view data source and delegates
    //
    /////////////////////////////////////////////////////////////
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayFeatures.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellFeatureIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        let dictFeature = arrayFeatures[indexPath.row]
        cell.textLabel?.text = dictFeature["title"]
        cell.detailTextLabel?.text = dictFeature["subtitle"]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var photos:[MWPhoto] = []
        var photo:MWPhoto
        var displayActionButton:Bool = true;
        var displaySelectionButtons:Bool = false;
        var displayNavArrows:Bool = false;
        var enableGrid:Bool = true;
        var startOnGrid:Bool = false;
        var autoPlayOnAppear:Bool = false;
        switch indexPath.row {
        case 0:
            photo = MWPhoto(image: UIImage(named: "arrow"))
            photo.caption = "He is arrow the most menacing super hero of all"
            photos.append(photo)
            enableGrid = false
            break
        default:
            break
        }
        
        arrayPhotos = photos
        
        let photoBrowser = MWPhotoBrowser(delegate: self)
        photoBrowser.displayActionButton = displayActionButton
        photoBrowser.displayNavArrows = displayNavArrows
        photoBrowser.displaySelectionButtons = displaySelectionButtons
        photoBrowser.alwaysShowControls = displaySelectionButtons
        photoBrowser.zoomPhotosToFill = true
        photoBrowser.enableGrid = enableGrid
        photoBrowser.startOnGrid = startOnGrid
        photoBrowser.enableSwipeToDismiss = false
        photoBrowser.autoPlayOnAppear = autoPlayOnAppear
        photoBrowser.setCurrentPhotoIndex(UInt(0))
        
        if segmentControl.selectedSegmentIndex == 0 {
            self.navigationController?.pushViewController(photoBrowser, animated: true)
        }else {
            let navc = UINavigationController(rootViewController: photoBrowser)
            navc.modalTransitionStyle = .CrossDissolve
            self.presentViewController(navc, animated: true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension FYMenuTableViewController: MWPhotoBrowserDelegate {
    
    /////////////////////////////////////////////////////////////
    //
    // MARK: MWPhotoBrowserDelegate
    //
    /////////////////////////////////////////////////////////////
    
    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(arrayPhotos.count)
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        return arrayPhotos[Int(index)]
    }
    
//    func photoBrowser(photoBrowser: MWPhotoBrowser!, captionViewForPhotoAtIndex index: UInt) -> MWCaptionView! {
//        
//    }
}