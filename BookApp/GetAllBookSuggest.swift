//
//  GetAllBookSuggest.swift
//  BookApp
//
//  Created by kien le van on 8/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetAllBookSuggest: BaseTaskNetwork {
    
    override func path() -> String! {
        return getAllBookSuggest
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": "0", "limit": "3"]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listBook = [Book]()
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let book: Book = Book(name: "", author: "", imageUrl: "", numberReaded: "", timeUp: "", audio: "", id: 999)
                book.id = dictionary["post_id"] as? Int ?? 999
                book.name = dictionary["post_name"] as? String ?? "123"
                book.author = dictionary["author"] as? String ?? "23"
                book.imageURL = dictionary["post_image"] as? String ?? "123"
                book.description = dictionary["post_description"] as? String ?? "123"
                book.timeUpBook = dictionary["created_at"] as? String ?? "123"
                book.audio = dictionary["post_audio"] as? String ?? "123"
                book.content = dictionary["post_content"] as? String ?? "abc"
                listBook.append(book)
            }
        }
        return listBook
    }
}
