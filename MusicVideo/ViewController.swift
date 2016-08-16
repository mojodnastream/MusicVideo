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
        
        doTest()
        
    }
    
    func doTest() {
        for item in videos {
            print("mytest name = \(item.vName)")
        }
    }
    

}

