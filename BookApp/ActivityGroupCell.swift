//
//  ActivityGroupCell.swift
//  BookApp
//
//  Created by kien le van on 9/8/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ActivityGroupCell: UITableViewCell {

    @IBOutlet weak var heightOfImage: NSLayoutConstraint!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusImage.layer.cornerRadius = heightOfImage.constant / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func binData(group: SecrectGroup) {
        name.text = group.name
        statusImage.backgroundColor = UIColor.rgb(red: 201, green: 201, blue: 201)
        for groupJoined in Constants.sharedInstance.listGroupJoined where group.idGroup == groupJoined.idGroup {
                statusImage.backgroundColor = UIColor.rgb(red: 255, green: 102, blue: 0)
        }
    }
}
