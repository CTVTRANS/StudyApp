//
//  BookCollectionViewCell.swift
//  BookApp
//
//  Created by kien le van on 8/17/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameBook: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func binData(book: Book) {
        nameBook.text = book.name
        let urlString = book.imageURL
        if (urlString != "abc") {
            let url = URL(string: urlString)
            let data = try? Data(contentsOf: url!)
            imageBook.image = UIImage(data: data!)
        }
    }
}
