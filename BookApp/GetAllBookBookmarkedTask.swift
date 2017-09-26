//
//  GetAllBookBookmarkedTask.swift
//  BookApp
//
//  Created by kien le van on 9/20/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetAllBookBookmarkedTask: BaseTaskNetwork {

    private var _page: Int
    
    init(page: Int) {
        _page = page
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func path() -> String! {
        return getAllBookBookmarkedURL
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["member_id": (Constants.sharedInstance.memberProfile?.idMember)!, "limit": 20, "page": _page]
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
