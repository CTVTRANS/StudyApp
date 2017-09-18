//
//  HeaderCollectionReusableView.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var showAll: UIButton!
    @IBOutlet weak var markNumber: UILabel!
    @IBOutlet weak var showMark: UIButton!
    @IBOutlet weak var showMarkAndMoney: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAll.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
        showMark.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
        showMarkAndMoney.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
    }
    
    func binData() {
        
    }

    @IBAction func pressedShowAllButton(_ sender: Any) {
        
    }
    
    @IBAction func pressedShowMarkButton(_ sender: Any) {
        print("2")
    }
    
    @IBAction func pressShowMarkAndMoney(_ sender: Any) {
        print("3")    }

}
