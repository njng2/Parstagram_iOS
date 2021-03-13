//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Nancy Ng  on 3/12/21.
//

import UIKit
import Parse
import AlamofireImage
class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    

    @IBOutlet weak var PostView: UITableView!
  
    var posts  = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostView.delegate = self
        PostView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    //where quereing stuff
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Posts")
        query.includeKey("Author")//fetch object
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.PostView.reloadData();
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        let user = post["Author"] as! PFUser
        print("username is used here")
        cell.usernameLabel.text = user.username
        
        cell.commentsLabel.text = post["Caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string:urlString)!
        
        cell.ImageCell.af_setImage(withURL:url)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
