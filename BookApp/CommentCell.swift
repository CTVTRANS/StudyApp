//
//  CommentCell.swift
//  BookApp
//
//  Created by kien le van on 8/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var numberLike: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func binData(commentObject: Comment) {
        name.text = commentObject.userComment.name
        avatar.sd_setImage(with: URL(string: commentObject.userComment.avata))
        time.text = commentObject.timeComment
        content.text = commentObject.contentComment
        numberLike.text = commentObject.numberLikeComment
    }

}
