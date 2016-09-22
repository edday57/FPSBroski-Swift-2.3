//
//  PlaylistVideosModel.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit
import Alamofire

protocol PlaylistVideosModelDelegate {
    func playlistVideosAreReady()
}

class PlaylistVideosModel: NSObject {
    private var API_KEY = "AIzaSyDb8JKcWnCYEAaXFGXIyZc8HWUVljD8zfQ"
    private var urlString = "https://www.googleapis.com/youtube/v3/playlistItems"
    var delegate: PlaylistVideosModelDelegate!
    
    var playlistVideosArray = [PlaylistVideos]()
    
    
    
    func getplaylistVideos(playlist_Id: String){
        
        Alamofire.request(.GET, urlString, parameters: ["part":"snippet","maxResults":"30","key":API_KEY, "playlistId":playlist_Id], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            if let jsonResult = response.result.value{
                var videosArray = [PlaylistVideos]()
                
                for video in jsonResult["items"] as! NSArray{
                    
                    let playlistVideo = PlaylistVideos()
                    
                    playlistVideo.title = video.valueForKeyPath("snippet.title") as! String
                    playlistVideo._description = video.valueForKeyPath("snippet.description") as! String
                    playlistVideo.id = video.valueForKeyPath("snippet.resourceId.videoId") as! String
                    
                    if  video.valueForKeyPath("snippet.thumbnails.maxres.url") != nil {
                        playlistVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.maxres.url") as! String
                    }else if video.valueForKeyPath("snippet.thumbnails.standard.url") != nil {
                        playlistVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.standard.url") as! String
                    }else if video.valueForKeyPath("snippet.thumbnails.high.url") != nil {
                        playlistVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.high.url") as! String
                    }else if video.valueForKeyPath("snippet.thumbnails.medium.url") != nil {
                        playlistVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.medium.url") as! String
                    }else{
                        playlistVideo.thumbnailUrl = video.valueForKeyPath("snippet.thumbnails.default.url") as! String
                        
                    }
                    
                    
                    videosArray.append(playlistVideo)
                    
                }
                
                self.playlistVideosArray = videosArray
                
                
                if self.delegate != nil {
                    self.delegate.playlistVideosAreReady()
                }
                
                
                
            }
        }


}
}