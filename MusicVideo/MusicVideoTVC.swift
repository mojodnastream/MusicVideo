//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Gary Nothom on 8/23/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {
  
    var videos = [Videos]()
    var filterSearch = [Videos]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limit = 10
    var APIString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChanged() {
        print("the preferred font has changed")
    }
    
    func didLoadData(_ videos: [Videos]) {
        self.videos = videos
        for item in videos {
            print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerated() {
            print("\(index) name = \(item.vName)")
        }
        
        title = ("The iTunes top \(limit) videos")
        
        //Setup Search Controller
        
        resultSearchController.searchResultsUpdater = self
        definesPresentationContext = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for Videos"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
        
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Internet Access", message: "Please get your internets sorted out", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
                    action -> () in
                    print("Cancel")
                }
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                    action -> () in
                    print("Delete")
                }
                let okAction = UIAlertAction(title: "OK", style: .default) {
                    action -> Void in
                    print("OK")
                }
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        
        default:
            //view.backgroundColor = UIColor.greenColor()
            
            if videos.count > 0 {
                print("we're good, dont run API")
            } else {
                runAPI()
            }
        }
    }
    
    func refresher() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDte = formatter.string(from: NSDate() as Date)
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
        
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        
        if resultSearchController.isActive {
             refreshControl?.attributedTitle = NSAttributedString(string: "No Refresh on Search")
        } else {
            runAPI()
        }
    }
    
    func getAPICount() {
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            limit = theValue
        }
        APIString = "https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json"
        
        refresher()
        
    }
    
    func runAPI() {
        //call API
        getAPICount()
        let api = APIManager()
        api.loadData(APIString, completion: didLoadData)
    }
    
    //blow out the observers
    deinit
    {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if resultSearchController.isActive {
            return filterSearch.count
        }
        return videos.count
    }

    fileprivate struct storybaord {
        static let cellReuseIdentifier = "cell"
        static let sequeIdentifier = "musicDetail"
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: storybaord.cellReuseIdentifier, for: indexPath) as!MusicVideoTableViewCell
        
        if resultSearchController.isActive {
            cell.video = filterSearch[indexPath.row]
        }   else {
            cell.video = videos[indexPath.row]
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storybaord.sequeIdentifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                
                let video: Videos
                
                if resultSearchController.isActive {
                    video = filterSearch[indexpath.row]
                    
                }   else {
                    
                    video = videos[indexpath.row]
                }
                
                let dvc = segue.destination as! MusicVideoDetailVC
                dvc.videos = video
                
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.text!.lowercased()
        filterSearch(searchText: searchController.searchBar.text!)
    }
    
    func filterSearch(searchText: String) {
        filterSearch = videos.filter { videos  in
            return videos.vArtist.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

}
