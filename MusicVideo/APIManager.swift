//
//  APIManager.swift
//  MusicVideo
//
//  Created by Gary Nothom on 7/26/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: @escaping ([Video]) -> Void ) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        //        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTask(with: url as URL) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                let videos = self.parseJson(data: data as NSData?)
                
                    DispatchQueue.global(qos: .default).sync {
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            }
        }
        task.resume()
    }
    
    func parseJson(data: NSData?) -> [Video] {
        
        do {
            
            if let json = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject? {
                
                return JsonDataExtractor.extractVideoDataFromJson(videoDataObject: json)
            }
        }
            
        catch {
            print("Failed to parse data: \(error)")
        }
        
        return [Video]()
    }
    
    
}





