//
//  RecentVideosTableViewController.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit


class RecentVideosTableViewController: UITableViewController, RecentVideosModelDelegate {

    var model = RecentVideosModel()
    var videosArray = [RecentVideos]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        model.delegate = self
        model.getRecentVideos()
        self.navigationItem.title = "Recent Videos"
        
    }



    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videosArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recentVideosCell", forIndexPath: indexPath) as! RecentVideosTableViewCell

        // Configure the cell...
        configureCell(cell, indexPath: indexPath)

        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showVideo", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showVideo" {
            let vc = segue.destinationViewController as! VideoDetailsTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            vc.vidId = videosArray[indexPath.row].id
            vc.vidTitle = videosArray[indexPath.row].title
            vc.vidDescription = videosArray[indexPath.row]._description
        }
    }
    func recentVideosAreReady() {
        self.videosArray = model.recentVideos
        self.tableView.reloadData()
    }
   
    func configureCell(cell: RecentVideosTableViewCell, indexPath: NSIndexPath){
        
        cell.videoTitle.text = videosArray[indexPath.row].title
        
        let urlString = videosArray[indexPath.row].thumbnailUrl
        let url = NSURL(string: urlString)
        if let url = url {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                dispatch_async(dispatch_get_main_queue(), { 
                    if error == nil {
                        if let data = data{
                            cell.videoThumbnailImageView.image = UIImage(data: data)
                        }
                        
                    }else{
                        print(error?.localizedDescription)
                    }
                })

            })
            task.resume()
        }
        
        
    }
}
