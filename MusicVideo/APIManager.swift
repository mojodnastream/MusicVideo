//
//  APIManager.swift
//  MusicVideo
//
//  Created by Gary Nothom on 7/26/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion: @escaping ([Videos])-> Void) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            
            if error != nil {

                print(error!.localizedDescription)
                
            } else {
                
                print(data)
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!,
                        options: .allowFragments) as? JSONDictionary,
                        let feed = json["feed"] as? JSONDictionary,
                        let entries = feed["entry"] as? JSONArray {
                    
                        var videos = [Videos]()
                        for(index, entry) in entries.enumerated() {
                            let entry = Videos(data: entry as! JSONDictionary)
                            entry.vRank = index + 1
                            videos.append(entry)
                        }
                        
                        let i = videos.count
                        print("iTunesAPIManager = total count --> \(i)")
                        print(" ")
                        
                        //let priority = DispatchQueue.GlobalQueuePriority.high
                        DispatchQueue.global(qos: .default).sync {
                            //DispatchQueue.global(priority: priority).async {
                            DispatchQueue.main.async {
                                completion(videos)
                            }
                        }
                    
                    }
                } catch {
                    
                    print("error in NSJSONSerialization")
                
                }
            
            }
        }) 
        task.resume()
    }
}
