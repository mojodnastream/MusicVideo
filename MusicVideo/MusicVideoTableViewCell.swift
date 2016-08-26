//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Gary Nothom on 8/24/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    //PUT ALL LOGIC IN THE CELL, NOT THE VC
    
    var video : Videos? {
        didSet {
            updateCell()
        }
    }

    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var rank: UILabel!
 
    func updateCell() {
        
        musicTitle.text = video!.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video?.vImageData != nil {
            print("get image from array")
            musicImage.image = UIImage(data: video!.vImageData!)
        }
        else {
            GetVideoImage(video!, imageView: musicImage)
        }
        
    }
    
    func GetVideoImage(video: Videos, imageView : UIImageView) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string:video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //move back to main queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
}
