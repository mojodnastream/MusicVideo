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
        musicImage.image = UIImage(named: "imageNotAvailable")
        
        
    }
}
