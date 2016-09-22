//
//  PlaylistsTableViewController.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class PlaylistsTableViewController: UITableViewController, PlaylistModelDelegate {

    var playlistsArray = [Playlist]()
    var model = PlaylistModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        model.delegate = self
        model.getPlaylists()
        self.navigationItem.title = "Playlists"
    }



    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlistsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playlistCell", forIndexPath: indexPath) as! PlaylistsTableViewCell

        // Configure the cell...
        configureCell(cell, indexPath: indexPath)
        return cell
    }
 
    func playlistsAreReady() {
        self.playlistsArray = model.playlistArray
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showPlaylist", sender: self)
    }
    
    
    func configureCell(cell: PlaylistsTableViewCell, indexPath: NSIndexPath){
        
        cell.playlistTitleLabel.text = playlistsArray[indexPath.row].title
        cell.numberOfVideos.text = "Number of Videos: \(playlistsArray[indexPath.row].numberOfVideos)"
        let urlString = playlistsArray[indexPath.row].thumbnailUrl
        let url = NSURL(string: urlString)
        if let url = url {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    if error == nil {
                        if let data = data{
                            cell.playlistImageView.image = UIImage(data: data)
                        }
                        
                    }else{
                        print(error?.localizedDescription)
                    }
                })
                
            })
            task.resume()
        }
        

        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaylist"{
            let vc = segue.destinationViewController as! PlaylistVideosTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            vc.playlistId = playlistsArray[indexPath.row].id
            vc.playlistTitle = playlistsArray[indexPath.row].title
            
            
        }
    }
}