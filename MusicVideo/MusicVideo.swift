//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Gary Nothom on 7/27/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import Foundation

class Video {
    
    // data encapsulation
    private(set) var vRank:Int
    private(set) var vName:String
    private(set) var vImageUrl:String
    private(set) var vVideoUrl:String
    private(set) var vRights:String
    private(set) var vPrice:String
    private(set) var vArtist:String
    private(set) var vImid:String
    private(set) var vGenre:String
    private(set) var vLinkToiTunes:String
    private(set) var vReleaseDate:String
    
    //Greated from UI
    var vImageData:Data?
    
    init(vRank:Int, vName:String, vImageUrl:String, vVideoUrl:String, vRights:String, vPrice:String, vArtist:String, vImid:String, vGenre:String, vLinkToiTunes:String, vReleaseDate:String) {
        
        self.vRank = vRank
        self.vName = vName
        self.vImageUrl = vImageUrl
        self.vVideoUrl = vVideoUrl
        self.vRights = vRights
        self.vReleaseDate = vReleaseDate
        self.vPrice = vPrice
        self.vArtist = vArtist
        self.vImid = vImid
        self.vGenre = vGenre
        self.vLinkToiTunes = vLinkToiTunes
    }
}

//        
//        //Video Name
//        
//        if let name = data["im:name"] as? JSONDictionary,
//            let vName = name["label"] as? String {
//            
//                self.vName = vName
//            
//        }
//        //Video Image
//        
//        if let img = data["im:image"] as? JSONArray,
//            let image = img[2] as? JSONDictionary,
//            let immage = image["label"] as? String {
//            vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
//        }
//        
//        //Video  URL
//        
//        if let video = data["link"] as? JSONArray,
//            let vUrl = video[1] as? JSONDictionary,
//            let vHref = vUrl["attributes"] as? JSONDictionary,
//            let vVideoUrl = vHref["href"] as? String {
//                self.vVideoUrl = vVideoUrl
//        }
//        //Rights
//        
//        if let rights = data["rights"] as? JSONDictionary,
//            let vRights = rights["label"] as? String {
//            
//            self.vRights = vRights
//        }
//      
//        //Price
//        
//        if let price = data["im:price"] as? JSONDictionary,
//            let vPrice = price["label"] as? String {
//            
//            self.vPrice = vPrice
//        }
//    
//        //Artist
//        
//        if let artist = data["im:artist"] as? JSONDictionary,
//            let vArtist = artist["label"] as? String {
//            
//            self.vArtist = vArtist
//        }
//        
//        //IMID
//        
//        if let imid = data["id"] as? JSONDictionary,
//            let vid = imid["attributes"] as? JSONDictionary,
//            let vImid = vid["im:id"] as? String {
//            
//            self.vImid = vImid
//        }
//        
//        //GENRE
//        
//        if let genre = data["category"] as? JSONDictionary,
//            let rel2 = genre["attributes"] as? JSONDictionary,
//            let vGenre = rel2["term"] as? String {
//                self.vGenre = vGenre
//        }
//        
//        //Link To iTunes
//        
//        if let release2 = data["id"] as? JSONDictionary,
//            let vLinkToiTunes = release2["label"] as? String {
//                self.vLinkToiTunes = vLinkToiTunes
//        }
//        
//        
//        //Release Date
//        
//        if let release2 = data["im:releaseDate"] as? JSONDictionary,
//            let rel2 = release2["attributes"] as? JSONDictionary,
//            let vReleaseDate = rel2["label"] as? String {
//                self.vReleaseDate = vReleaseDate
//        }
//        
