//
//  Notification.swift
//  BookApp
//
//  Created by kien le van on 10/3/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

struct NotificationApp {
    var idNotification: Int
    var title: String
    var image: String
    var detailText: String
    var appName: String
    
    init(_ idNotiFication: Int, title: String, image: String, detailText: String, appName: String) {
        self.idNotification = idNotiFication
        self.title = title
        self.image = image
        self.detailText = detailText
        self.appName = appName
    }
}
