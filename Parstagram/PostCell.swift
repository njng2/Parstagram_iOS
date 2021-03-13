//
//  PostCell.swift
//  Parstagram
//
//  Created by Nancy Ng  on 3/13/21.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var ImageCell: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
