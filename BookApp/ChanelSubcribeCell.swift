//
//  TeacherSubcribeCell.swift
//  BookApp
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ChanelSubcribeCell: UITableViewCell {
    
    var callBack = {}
    
    @IBOutlet weak var downloadButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        downloadButton.layer.borderColor = UIColor.rgb(r: 245, g: 166, b: 35).cgColor
    }

    @IBAction func pressedDownloadButton(_ sender: Any) {
        self.callBack()
    }
    
}
