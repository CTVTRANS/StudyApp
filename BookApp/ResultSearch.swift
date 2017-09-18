//
//  ResultSearchCell.swift
//  BookApp
//
//  Created by kien le van on 9/16/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ResultSearch: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func binData(objec: Any) {
        if let book = objec as? Book {
            title.text = book.name
            descriptionTitle.text = book.description
            return
        }
        if let news = objec as? NewsModel {
            title.text = news.title
            descriptionTitle.text = news.detailNews
        }
    }
}
