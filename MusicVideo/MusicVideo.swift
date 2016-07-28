//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Gary Nothom on 7/27/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import Foundation

class Videos {
    
    // data encapsulation
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    //Getters
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        
        
        //Video Name
        
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            
                self._vName = vName
            
        }
        else {
            _vName = ""
        }
        
        //Video Image
        
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else {
            _vImageUrl = ""
        }
        
        
        //Video  URL
        
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        }
        else {
            _vVideoUrl = ""
        }

        
    }
    
}
