//
//  RecentVideosModel.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit
import Alamofire

protocol RecentVideosModelDelegate {
    func recentVideosAreReady()
}

class RecentVideosModel: NSObject {
    
    private var API_KEY = "AIzaSyDb8JKcWnCYEAaXFGXIyZc8HWUVljD8zfQ"
    private var urlString = "https://www.googleapis.com/youtube/v3/playlistItems"
    private var playlist_Id = "UUAtIMvDkcvBR7haTLsLZoSg"
    var delegate: RecentVideosModelDelegate!

    var recentVideos = [RecentVideos]()
    
    

    func getRecentVideos(){
        
        Alamofire.request(.GET, urlString, parameters: ["part":"snippet","maxResults":"30","key":API_KEY, "playlistId":playlist_Id], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            if let jsonResult = response.result.value{
                var videosArray = [RecentVideos]()
                
                for video in jsonResult["items"] as! NSArray{
                    
                    let recentVideo = RecentVideos()
                    
                    recentVideo.title = video.valueForKeyPath("snippet.title") as! String
                    recentVideo._description = video.valueForKeyPath("snippet.description") as! String
                    recentVideo.id = video.valueForKeyPath("snippet.resourceId.videoId") as! String
                    
                    if  video.valueForKeyPath("snippet.thumbnails.maxres.url") != nil {
                        recentVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.maxres.url") as! String
                    }else if video.valueForKeyPath("snippet.thumbnails.standard.url") != nil {
                        recentVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.standard.url") as! String
                    }else if video.valueForKeyPath("snippet.thumbnails.high.url") != nil {
                        recentVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.high.url") as! String
                    }else if video.valueForKeyPath("snippet.thumbnails.medium.url") != nil {
                        recentVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.medium.url") as! String
                    }else{
                        recentVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.default.url") as! String
                        
                    }
                    
                    
                    videosArray.append(recentVideo)
                    
                }
                
                self.recentVideos = videosArray
                

                if self.delegate != nil {
                    self.delegate.recentVideosAreReady()
                }
                

                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
