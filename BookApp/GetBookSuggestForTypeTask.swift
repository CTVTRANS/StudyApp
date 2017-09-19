//
//  GetBookSuggestForType.swift
//  BookApp
//
//  Created by kien le van on 8/30/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetBookSuggestForTypeTask: BaseTaskNetwork {
    
    private let _category: Int!
    private let _limit: Int!
    
    init(category: Int, limit: Int) {
        _category = category
        _limit = limit
    }
    
    override func path() -> String! {
        return getBookSuggestForTypeURL
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["category": _category, "limit": _limit]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listBook: [Book] = []
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let book = self.parseBook(dictionary: dictionary)
                listBook.append(book)
            }
        }
        return listBook
    }
}
