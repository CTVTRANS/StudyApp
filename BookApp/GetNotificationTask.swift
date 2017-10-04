//
//  GetNotificationTask.swift
//  BookApp
//
//  Created by kien le van on 10/3/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetNotificationTask: BaseTaskNetwork {
    
    private var _limit: Int!
    private var _page: Int!
    
    init(limit: Int, page: Int) {
        _limit = limit
        _page = page
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func path() -> String! {
        return getNotification
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": Constants.sharedInstance.language,
                "type": "text",
                "limit": _limit,
                "page": _page]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listNotification: [NotificationApp] = []
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let idNotification = dictionary["id"] as? Int ?? 9999
                let title = dictionary["title"] as? String ?? " "
                let image = dictionary["image"] as? String ?? " "
                let detail = dictionary["notification_text"] as? String ?? " "
                let appName = dictionary["description"] as? String ?? " "
                let notification = NotificationApp.init(idNotification, title: title, image: image, detailText: detail, appName: appName)
                listNotification.append(notification)
            }
        }
        return listNotification
    }
}
