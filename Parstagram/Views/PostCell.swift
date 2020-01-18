//
//  PostCell.swift
//  Parstagram
//
//  Created by Jesus Andres Bernal Lopez on 1/10/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    var post: PFObject! {
        didSet {            
            let user = post["author"] as! PFUser
            authorLabel.text = user.username
            
            captionLabel.text = post["caption"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            let data = try! Data(contentsOf: url)

            photoImageView.image = UIImage(data: data)
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
