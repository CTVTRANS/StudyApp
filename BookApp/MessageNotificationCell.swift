//
//  MessageNotificationCell.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class MessageNotificationCell: UITableViewCell {

    @IBOutlet weak var detailApp: UILabel!
    @IBOutlet weak var titleNotification: UILabel!
    @IBOutlet weak var imageNotification: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func binData(objectNotification: NotificationApp) {
        detailApp.text = objectNotification.appName
        titleNotification.text = objectNotification.title
        imageNotification.sd_setImage(with: URL(string: objectNotification.image), placeholderImage: #imageLiteral(resourceName: "place_holder"))
    }
}
