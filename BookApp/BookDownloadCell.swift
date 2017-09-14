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
    
    @IBOutlet weak var imagePlay: UIImageView!
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var timeUp: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionBook: UILabel!
    @IBOutlet weak var numberView: UILabel!
    
    var callBackButton:((_ action: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        removeButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor

    }

    func binData(book: Book) {
        type.text = " " + book.typeName + " "
        name.text = book.name
        descriptionBook.text = book.author
        numberView.text = String(book.numberHumanReaed)
        imageBook.sd_setImage(with: URL(string: book.imageURL))
        let date = book.timeUpBook.components(separatedBy: " ")
        timeUp.text = date[0]
    }

    
    @IBAction func pressedPlayButton(_ sender: Any) {
        self.callBackButton!("playBook")
    }
 
    @IBAction func pressedRemoveButton(_ sender: Any) {
        self.callBackButton!("removeBook")
    }
}
