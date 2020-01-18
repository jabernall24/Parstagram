//
//  CommentCell.swift
//  Parstagram
//
//  Created by Jesus Andres Bernal Lopez on 1/17/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class CommentCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    var comment: PFObject! {
        didSet {
            commentLabel.text = comment["text"] as? String
            
            let user = comment["author"] as! PFUser
            nameLabel.text = user.username
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
