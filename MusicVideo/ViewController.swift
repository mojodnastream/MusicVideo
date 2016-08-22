//
//  ViewController.swift
//  MusicVideo
//
//  Created by Gary Nothom on 7/25/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Videos]()

    @IBOutlet weak var tableView: UITableView!
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
        
        tableView.reloadData()
        
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
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
         return videos.count
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1 )")
        cell.detailTextLabel?.text = video.vName
        
        return cell
        
        
    }
    
    
}

