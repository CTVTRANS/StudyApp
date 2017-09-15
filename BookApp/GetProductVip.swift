//
//  GetProductVip.swift
//  BookApp
//
//  Created by kien le van on 9/15/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetProductVip: BaseTaskNetwork {
    
    override func path() -> String! {
        return getAllVipProductURL
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": Constants.sharedInstance.language]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var vip: Vip?
        if let dictionary = response as? [String: Any] {
            let idVip = dictionary["id"] as? Int ?? 123
            let titleVip = dictionary["title"] as? String ?? "123"
            let imageVip = dictionary["image"] as? String ?? "123"
            let descriptionVip = dictionary["description"] as? String ?? "dasdf"
            let contentVip = dictionary["content"] as? String ?? "sdaf"
            let priceVip = dictionary["price"] as? Int ?? 123
            vip = Vip(id: idVip,
                      title: titleVip,
                      imageURL: imageVip,
                      description: descriptionVip,
                      content: contentVip,
                      price: priceVip)
        }
        return vip
    }

}
