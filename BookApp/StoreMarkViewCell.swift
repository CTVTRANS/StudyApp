//
//  MarkCollectionViewCell.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class StoreMarkViewCell: UICollectionViewCell {

    @IBOutlet weak var pointBookView: UIView!
    @IBOutlet weak var moneyBookView: UIView!
    @IBOutlet weak var moneyBook: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var moneyVipView: UIView!
    @IBOutlet weak var moneyVip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binData(product: AnyObject, type: TypeProductRequest) {
        if let book = product as? Book {
            moneyVipView.isHidden = true
            title.text = book.name
            if type == TypeProductRequest.pointAndMoney ||
                (type == TypeProductRequest.all && book.price == 0) {
                let pirce_Mix: PriceMix = book.priceMix
                let pricePoint = pirce_Mix.point
                let priceMoney = pirce_Mix.mooney
                point.text = String(pricePoint)
                moneyBook.text = String(priceMoney)
                return
            } else if type == TypeProductRequest.point ||
                (type == TypeProductRequest.all && book.price != 0) {
                point.text = String(book.price!)
                moneyBookView.isHidden = true
                return
            }
            return
        }
        if let vip = product as? Vip {
            moneyBookView.isHidden = true
            pointBookView.isHidden = true
            title.text = vip.title
            moneyVip.text = String(vip.price)
            
        }
    }
}
