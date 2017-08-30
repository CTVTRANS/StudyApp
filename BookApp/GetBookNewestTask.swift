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
        var bookNewest: Book?
        if let object = response as? [[String: Any]] {
            let dictionary = object[0]
            let idBook = dictionary["post_id"] as? Int ?? 999
            let nameBook = dictionary["post_name"] as? String ?? "123"
            let authorBook = dictionary["author"] as? String ?? "23"
            let imageURLBook = dictionary["post_image"] as? String ?? "123"
            let descriptionBook = dictionary["post_description"] as? String ?? "123"
            let audioBook = dictionary["post_audio"] as? String ?? "123"
            let videoBook = dictionary["post_video"] as? String ?? "123"
            let contentBook = dictionary["post_content"] as? String ?? "abc"
            let timeUpBook = dictionary["updated_at"] as? String ?? "123"
            let numberLikeBook = dictionary["number_of_likes"] as? Int ?? 123
            let numberCommentBook = dictionary["number_of_comments"] as? Int ?? 123
            
            bookNewest = Book(id: idBook,
                                  name: nameBook,
                                  author: authorBook,
                                  imageUrl: imageURLBook,
                                  numberReaded: 123,
                                  timeUp: timeUpBook,
                                  audio: audioBook,
                                  video: videoBook,
                                  content: contentBook,
                                  numberLike: numberLikeBook,
                                  numberComment: numberCommentBook,
                                  numberBookMark: 123,
                                  desCription: descriptionBook)
        }
        return bookNewest
    }
}
