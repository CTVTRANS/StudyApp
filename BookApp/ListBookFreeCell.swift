//
//  ListBookFreeCell.swift
//  BookApp
//
//  Created by kien le van on 8/31/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ListBookFreeCell: UITableViewCell {

    @IBOutlet weak var timeUp: UILabel!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var descriptionbook: UILabel!
    @IBOutlet weak var namebook: UILabel!
    @IBOutlet weak var typeBook: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func binData(book: Book) {
        typeBook.text = " " + book.typeName + " "
        namebook.text = book.name
        descriptionbook.text = book.author
        numberView.text = String(book.numberHumanReaed)
        imageBook.sd_setImage(with: URL(string: book.imageURL))
        let date = book.timeUpBook.components(separatedBy: " ")
        timeUp.text = date[0]
    }

}
