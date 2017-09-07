//
//  HisToryWatchChanelCell.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class HisToryWatchChanelCell: UITableViewCell {

    @IBOutlet weak var removeChanelButton: UIButton!
    @IBOutlet weak var playChanelButton: UIButton!
    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playChanelButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        removeChanelButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
    }
    
    @IBAction func pressedPlayChanelButton(_ sender: Any) {
        
    }
    @IBAction func pressedRemoveChanelButton(_ sender: Any) {
        
    }

}
