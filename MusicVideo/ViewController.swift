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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

