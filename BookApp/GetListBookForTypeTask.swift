//
//  GetListBookForTypeTask.swift
//  BookApp
//
//  Created by kien le van on 8/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetListBookForTypeTask: BaseTaskNetwork {
    
    let _category: Int!
    let _page: String!
    
    init(category: Int, page: String) {
        _category = category
        _page = page
    }

    override func path() -> String! {
        return getBookForEachType
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["category": _category, "page": _page]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listBook = [Book]()
        if let listObject = response as? [[String: Any]] {
            for dictionary in listObject {
                let book: Book = Book(name: "", imageUrl: "", numberReaded: "", timeUp: "", audio: "", id: "")
                book.id = dictionary["post_id"] as? String ?? ""
                book.name = dictionary["post_name"] as? String ?? ""
                book.imageURL = dictionary["post_image"] as? String ?? ""
                book.description = dictionary["post_description"] as? String ?? ""
                book.audio = dictionary["post_audio"] as? String ?? ""
                book.content = dictionary["post_content"] as? String ?? ""
                listBook.append(book)
            }
        }
        return listBook
    }
}
