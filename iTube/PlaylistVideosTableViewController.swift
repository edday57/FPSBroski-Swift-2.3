//
//  PlaylistVideosTableViewController.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class PlaylistVideosTableViewController: UITableViewController, PlaylistVideosModelDelegate {
    
    
    var model = PlaylistVideosModel()
    var playlistVideosArray = [PlaylistVideos]()
    var playlistId: String!
    var playlistTitle: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.getplaylistVideos(playlistId)

        self.navigationItem.title = playlistTitle
    }
    
    // MARK: - Table view data source



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlistVideosArray.count
    }

    func playlistVideosAreReady() {
        self.playlistVideosArray = model.playlistVideosArray
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playlistVideosCell", forIndexPath: indexPath) as! PlaylistVideosTableViewCell

        // Configure the cell...
        configureCell(cell, indexPath: indexPath)

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showVideo2", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showVideo2" {
            let vc = segue.destinationViewController as! VideoDetailsTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            vc.vidId = playlistVideosArray[indexPath.row].id
            vc.vidTitle = playlistVideosArray[indexPath.row].title
            vc.vidDescription = playlistVideosArray[indexPath.row]._description
        }
    }

    
    func configureCell(cell: PlaylistVideosTableViewCell, indexPath: NSIndexPath){
        
        cell.playlistVideosTitleLabel.text = playlistVideosArray[indexPath.row].title
        
        let urlString = playlistVideosArray[indexPath.row].thumbnailUrl
        let url = NSURL(string: urlString)
        if let url = url {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    if error == nil {
                        if let data = data{
                            cell.playlistVideosImageView.image = UIImage(data: data)
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
