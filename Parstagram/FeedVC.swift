//
//  FeedVC.swift
//  Parstagram
//
//  Created by Jesus Andres Bernal Lopez on 1/10/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class FeedVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { [weak self] posts, error in
            guard let self = self else { return }
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            } else {
                self.performOkayAlertWith(title: "Error retrieving posts", message: error!.localizedDescription)
            }
        }
    }

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.authorLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        
        let image = posts[indexPath.row]["image"] as? PFFileObject
        image?.getDataInBackground(block: { data, error in
            if error == nil{
                let postImage = UIImage(data: data!)
                cell.photoImageView.image = postImage
            }
        })
                
        return cell
    }
    
    
}
