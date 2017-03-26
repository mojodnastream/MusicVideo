//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Gary Nothom on 9/8/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {
    
    var videos:Videos!
    
    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        shareMedia()
    }
    
    func shareMedia() {
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step It UP!)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4,activity5], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes =  [UIActivityTypeMail]
        
        
        
        //        activityViewController.excludedActivityTypes =  [
        //            UIActivityTypePostToTwitter,
        //            UIActivityTypePostToFacebook,
        //            UIActivityTypePostToWeibo,
        //            UIActivityTypeMessage,
        //            UIActivityTypeMail,
        //            UIActivityTypePrint,
        //            UIActivityTypeCopyToPasteboard,
        //            UIActivityTypeAssignToContact,
        //            UIActivityTypeSaveToCameraRoll,
        //            UIActivityTypeAddToReadingList,
        //            UIActivityTypePostToFlickr,
        //            UIActivityTypePostToVimeo,
        //            UIActivityTypePostToTencentWeibo
        //        ]
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityType.mail {
                print ("email selected")
            }
            
        }
        
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(url: url as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
        
    }
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.vArtist
        vName.text = videos.vName
        vGenre.text = videos.vGenre
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData! as Data)
        }
        else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
        
        

        // Do any additional setup after loading the view.
         NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoDetailVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    func preferredFontChanged() {
        print("the preferred font has changed")
    }
    
    //blow out the observers
    deinit
    {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }


}
