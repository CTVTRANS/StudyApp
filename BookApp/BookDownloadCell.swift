//
//  BookDownloadCell.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookDownloadCell: UITableViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        removeButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor

    }

    func binData(book: Book) {
//        typeBook.text = " " + book.typeName + " "
//        namebook.text = book.name
//        descriptionbook.text = book.author
//        numberView.text = String(book.numberHumanReaed)
//        imageBook.sd_setImage(with: URL(string: book.imageURL))
//        let date = book.timeUpBook.components(separatedBy: " ")
//        timeUp.text = date[0]
    }

    
    @IBAction func pressedPlayButton(_ sender: Any) {
        
    }
 
    @IBAction func pressedRemoveButton(_ sender: Any) {
        
    }
}
