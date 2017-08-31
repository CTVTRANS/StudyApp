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
        return ["lang": Constants.sharedInstance.language, "limit": "1"]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var bookNewest: Book?
        if let object = response as? [[String: Any]] {
            let dictionary = object[0]
            bookNewest = self.parseBook(dictionary: dictionary)
        }
        return bookNewest
    }
}
