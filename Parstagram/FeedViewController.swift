//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Nancy Ng  on 3/12/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,MessageInputBarDelegate  {
    
    

    @IBOutlet weak var PostView: UITableView!
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    var posts  = [PFObject]()
    var selectedPost : PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostView.delegate = self
        PostView.dataSource = self
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        PostView.keyboardDismissMode = .interactive
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(note:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    //hides the keyboard
    @objc func keyboardWillBeHidden(note: Notification){
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar;
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        //create the comment
        let comment = PFObject(className: "Comments")
        print("function went here in comments and posts")
        comment["text"] = text
        comment["Posts"] = selectedPost
        comment["Author"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")
        
        selectedPost.saveInBackground {
        (success, error) in
            if success{
                print("comment successfully saved")
            }
            else{
                print("error to save comment")
            }
        }
        
        PostView.reloadData()
        //clear and dismiss the input
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    
    
    
    //where quereing stuff
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Posts")
        //fetch author of comment and author and comments
        query.includeKeys(["Author", "comments", "comments.Author"])//fetch object
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.PostView.reloadData();
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1 photo with each comment
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? [] //takes on default value if the left side is nill
        //whatever is on the left- set to kill
        return comments.count + 2
        //iterate how many comments and the number of posts
       
    }
    
    //to read comments and the posts, think of this in a 2D array
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? [] //takes on default
        
        
        //the cell you return is the zeroth row.
        if indexPath.row == 0 {
            let cell = PostView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            
           
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
        else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell")
            as! CommentCell
            
            let comment = comments[indexPath.row - 1]
            print("code went here to get text")
            cell.commentLabel.text = comment["text"] as? String
            
            let user = comment["Author"] as! PFUser
            cell.UserLabel.text = user.username
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
    }
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        print("clicked buttons")
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
    //implementing comments
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //creating comment object
        
        let post = posts[indexPath.section]
        
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
         }
        
        selectedPost = post

        
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
