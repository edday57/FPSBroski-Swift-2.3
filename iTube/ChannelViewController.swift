//
//  ChannelViewController.swift
//  iTube
//
//  Created by Edward Day on 09/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, ChannelModelDelegate {

    @IBOutlet weak var numberOfViews: UILabel!
    @IBOutlet weak var numberOfSubscribers: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var numberOfVideosLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelBannerImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    
    var channelArray = [Channel]()
    var model = ChannelModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        model.delegate = self
        model.getChannel()
    }
    
    func channelIsReady() {
        self.channelArray = model.channelArray
        configureChannelViewController()
    }
    
    func configureChannelViewController(){
        
        numberOfViews.text = "Number of Views: \(channelArray[0].channelNumberOfViews)"
        numberOfSubscribers.text = "Number of Subscribers: \(channelArray[0].channelNumberOfSubscribers)"
        numberOfVideosLabel.text = "Number of Videos: \(channelArray[0].channelNumberOfVideos)"
        channelTitleLabel.text = channelArray[0].channelTitle
        descriptionTextView.text = channelArray[0].channelDescription
        
        let urlString = channelArray[0].channelImageUrl
        let url = NSURL(string: urlString)
        if let url = url {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    if error == nil {
                        if let data = data{
                            self.channelImageView.image = UIImage(data: data)
                        }
                        
                    }else{
                        print(error?.localizedDescription)
                    }
                })
                
            })
            task.resume()
        }
        
        let urlString1 = channelArray[0].channelBannerImageUrl
        let url1 = NSURL(string: urlString1)
        if let url1 = url1 {
            let request1 = NSURLRequest(URL: url1)
            let session1 = NSURLSession.sharedSession()
            let task1 = session1.dataTaskWithRequest(request1, completionHandler: { (data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    if error == nil {
                        if let data = data{
                            self.channelBannerImageView.image = UIImage(data: data)
                        }
                        
                    }else{
                        print(error?.localizedDescription)
                    }
                })
                
            })
            task1.resume()
        }

        
        
        
        
        
    }


}
