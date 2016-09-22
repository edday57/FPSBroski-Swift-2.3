//
//  ChannelModel.swift
//  iTube
//
//  Created by Edward Day on 09/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit
import Alamofire

protocol ChannelModelDelegate {
    func channelIsReady()
}



class ChannelModel: NSObject {

    private var API_KEY: String = "AIzaSyDb8JKcWnCYEAaXFGXIyZc8HWUVljD8zfQ"
    private let urlString: String = "https://www.googleapis.com/youtube/v3/channels"
    private let channelId: String = "UCAtIMvDkcvBR7haTLsLZoSg"
    var channelArray = [Channel]()
    var delegate: ChannelModelDelegate!
    
    func getChannel() {
        Alamofire.request(.GET, urlString, parameters: ["key":API_KEY, "part": "snippet,brandingSettings,statistics","id":channelId], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            
            if let JSON = response.result.value{
                var channelResult = [Channel]()
                for channelObj in JSON["items"] as! NSArray{
                    
                    let channel = Channel()
                    channel.channelTitle = channelObj.valueForKeyPath("snippet.title") as! String
                    channel.channelDescription = channelObj.valueForKeyPath("snippet.description") as! String
                    channel.channelNumberOfViews = channelObj.valueForKeyPath("statistics.viewCount") as! String
                    channel.channelNumberOfVideos = channelObj.valueForKeyPath("statistics.videoCount") as! String
                    channel.channelNumberOfSubscribers = channelObj.valueForKeyPath("statistics.subscriberCount") as! String
                    
                    if channelObj.valueForKeyPath("snippet.thumbnails.high.url") != nil {
                        channel.channelImageUrl = channelObj.valueForKeyPath("snippet.thumbnails.high.url") as! String
                    } else if channel.valueForKeyPath("snippet.thumbnails.medium.url") != nil {
                        channel.channelImageUrl = channelObj.valueForKeyPath("snippet.thumbnails.medium.url") as! String
                    }else{
                        channel.channelImageUrl = channelObj.valueForKeyPath("snippet.thumbnails.default.url") as! String
                     }
                    
                    if channelObj.valueForKeyPath("brandingSettings.image.bannerMobileHdImageUrl") != nil {
                        channel.channelBannerImageUrl =
                            channelObj.valueForKeyPath("brandingSettings.image.bannerMobileHdImageUrl") as! String
                                
                    } else if channelObj.valueForKeyPath("brandingSettings.image.bannerMobileImageUrl") != nil {
                        channel.channelBannerImageUrl =
                            channelObj.valueForKeyPath("brandingSettings.image.bannerMobileImageUrl") as! String
                        
                    }else{
                        channel.channelBannerImageUrl = channelObj.valueForKeyPath("brandingSettings.image.bannerImageUrl") as! String
                    }
                    channelResult.append(channel)
                }
                
                self.channelArray = channelResult
                if self.delegate != nil {
                    self.delegate.channelIsReady()
                }
            }
        }
    }
}
