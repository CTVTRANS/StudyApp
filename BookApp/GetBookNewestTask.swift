//
//  GetBookNewestTask.swift
//  BookApp
//
//  Created by kien le van on 8/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetBookNewestTask: BaseTaskNetwork {
    
    override func path() -> String! {
        return getBookNewest
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": "0", "limit": "1"]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        let bookNewest: Book = Book(name: "", author: "", imageUrl: "", numberReaded: "", timeUp: "", audio: "", id: 9999)
        if let object = response as? [[String: Any]] {
            let dictionary = object[0]
            bookNewest.id = dictionary["post_id"] as? Int ?? 9999
            bookNewest.name = dictionary["post_name"] as? String ?? "123"
            bookNewest.author = dictionary["author"] as? String ?? "23"
            bookNewest.imageURL = dictionary["post_image"] as? String ?? "123"
            bookNewest.description = dictionary["post_description"] as? String ?? "123"
            bookNewest.timeUpBook = dictionary["created_at"] as? String ?? "123"
            bookNewest.audio = dictionary["post_audio"] as? String ?? "123"
            bookNewest.content = dictionary["post_content"] as? String ?? "abc"
        }
        return bookNewest
    }
}
