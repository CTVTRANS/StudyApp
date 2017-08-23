//
//  BookTypeViewCell.swift
//  BookApp
//
//  Created by kien le van on 8/22/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookTypeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    func binData(typeBook: String) {
        title.text = typeBook
    }
}
