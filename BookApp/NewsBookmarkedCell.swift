//
//  NewsBookmarkedCell.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NewsBookmarkedCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var heightOfImage: NSLayoutConstraint!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = heightOfImage.constant / 2
    }

}
