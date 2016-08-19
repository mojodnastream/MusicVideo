//
//  ViewController.swift
//  MusicVideo
//
//  Created by Gary Nothom on 7/25/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged:", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        //call API
        let api = APIManager()
        api.loadData(APIString, completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]) {
        self.videos = videos
        for item in videos {
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet For You"
        case WIFI : view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "You are connected to WiFIs - Yay"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Be nice, you are on the networks"
        default:return
        }
    }
    
    //blow out the observers
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"ReachStatusChanged", object: nil)
    }
    
}

