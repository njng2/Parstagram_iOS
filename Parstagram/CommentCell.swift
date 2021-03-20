//
//  CommentCell.swift
//  Parstagram
//
//  Created by Nancy Ng  on 3/19/21.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
