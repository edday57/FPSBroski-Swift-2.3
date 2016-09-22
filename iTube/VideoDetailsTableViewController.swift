//
//  VideoDetailsTableViewController.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class VideoDetailsTableViewController: UITableViewController {



    @IBOutlet weak var videoDescription: UITextView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var vidTitle: String!
    var vidDescription: String!
    var vidId: String!

    override func viewDidLoad() {
        super.viewDidLoad()



    }

    override func viewWillAppear(animated: Bool) {
        videoDescription.text = vidDescription
        videoTitleLabel.text = vidTitle
        
        videoDescription.scrollRangeToVisible(NSRange(location: 0, length: 0))
        if let webView = webView {
            let bounds = UIScreen.mainScreen().bounds
            let width = bounds.size.width
            let height = webView.bounds.size.height
            webView.scrollView.scrollEnabled = false
            
            let embeddedString: String = "<html><head><style type=\"text/css\">body {background-color: transparent;color:white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(height) + "\"width=\"" + String(width) + "\" src=\"http://www.youtube.com/embed/" + vidId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            
            webView.loadHTMLString(embeddedString, baseURL: nil)
        }
    }

}
