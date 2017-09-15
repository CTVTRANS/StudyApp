//
//  MarkCollectionViewCell.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class StoreMarkViewCell: UICollectionViewCell {

    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binData(book: Book) {
        title.text = book.name
        if book.price == nil || book.price == 0 {
            let pirce_Mix: PriceMix = book.priceMix
            let pricePoint = pirce_Mix.point
            let priceMoney = pirce_Mix.mooney
            point.text = String(pricePoint)
            money.text = String(priceMoney)
            return
        }
        point.text = String(book.price!)
        moneyView.isHidden = true
    }

}
