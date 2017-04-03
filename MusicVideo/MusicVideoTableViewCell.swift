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
    
    var video : Video? {
        didSet {
            updateCell()
        }
    }

    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var rank: UILabel!
 
    func updateCell() {
        
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        musicTitle.text = video!.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video?.vImageData != nil {
            print("get image from array")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }
        else {
            GetVideoImage(video!, imageView: musicImage)
            print("get images from bg thread")
        }
        
    }
    
    func GetVideoImage(_ video: Video, imageView : UIImageView) {
        
        
        //DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            DispatchQueue.global(qos: .default).sync {
            let data = try? Data(contentsOf: URL(string:video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //move back to main queue
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}
