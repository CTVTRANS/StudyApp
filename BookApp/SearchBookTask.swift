//
//  SearchTask.swift
//  BookApp
//
//  Created by kien le van on 9/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class SearchBookTask: BaseTaskNetwork {

    private var _keyWord: String!
    private var _limit: Int!
    private var _page: Int!
    
    init(keyWord: String, limit: Int, page: Int) {
        _keyWord = keyWord
        _limit = limit
        _page = page
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["keyword": _keyWord,
                "lang": Constants.sharedInstance.language,
                "limit": _limit,
                "page": _page]
    }
    
    override func path() -> String! {
        return searchBookURL
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listBook: [Book] = []
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let book = parseBook(dictionary: dictionary)
                listBook.append(book)
            }
        }
        return listBook
    }
}
