//
//  MessageNotificationCell.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class MessageNotificationCell: UITableViewCell {

    @IBOutlet weak var timeUp: UILabel!
    @IBOutlet weak var marked: UIView!
    @IBOutlet weak var detailApp: UILabel!
    @IBOutlet weak var titleNotification: UILabel!
    @IBOutlet weak var imageNotification: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func binData(objectNotification: NotificationApp) {
        if objectNotification.isReaded {
            marked.removeFromSuperview()
        }
        let time = objectNotification.time.components(separatedBy: " ")[1]
        let index = time.index(time.startIndex, offsetBy: 5)
        timeUp.text = time.substring(to: index)
        detailApp.text = objectNotification.appName
        titleNotification.text = objectNotification.title
        imageNotification.sd_setImage(with: URL(string: objectNotification.image), placeholderImage: #imageLiteral(resourceName: "place_holder"))
    }
}
