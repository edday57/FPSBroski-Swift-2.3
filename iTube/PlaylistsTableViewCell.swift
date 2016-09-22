//
//  PlaylistsTableViewCell.swift
//  iTube
//
//  Created by Edward Day on 08/08/2016.
//  Copyright © 2016 Edward Day. All rights reserved.
//

import UIKit

class PlaylistsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var numberOfVideos: UILabel!
    @IBOutlet weak var playlistTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        playlistImageView.layer.cornerRadius = 10
        playlistImageView.clipsToBounds = true
    }



}
