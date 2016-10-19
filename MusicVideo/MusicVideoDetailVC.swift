//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Gary Nothom on 9/8/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {
    
    var videos:Videos!
    
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
