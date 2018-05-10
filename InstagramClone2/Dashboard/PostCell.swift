//
//  PostCell.swift
//  InstagramClone2
//
//  Created by Republisys on 09/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var usernameButton: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

