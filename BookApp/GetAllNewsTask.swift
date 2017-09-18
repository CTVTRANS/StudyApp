//
//  GetAllNewsTask.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetAllNewsTask: BaseTaskNetwork {
    
    private let _limit: Int!
    private let _page: Int!
    
    init(limit: Int, page: Int) {
        _limit = limit
        _page = page
    }

    override func path() -> String! {
        return getAllNewsURL
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": Constants.sharedInstance.language,
                "limit": _limit,
                "page": _page]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var araayNews = [NewsModel]()
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let newsID = dictionary["post_id"] as? Int ?? 123
                let newsAuthor = dictionary["author"] as? String ?? "kien"
                let newsName = dictionary["post_name"] as? String ?? "123"
                let newsImage = dictionary["post_image"] as? String ?? "123"
                let newsDescription = dictionary["post_description"] as? String ?? "123"
                let newsContent = dictionary["post_content"] as? String ?? "123"
                let newsNote = dictionary["post_note"] as? String ?? "123"
                let newsTimeup = dictionary["updated_at"] as? String ?? "123"
                let newsType = dictionary["post_display_type"] as? Int ?? 123
                let newsNameType = dictionary["post_name"] as? String ?? "123"
                let newsNumberLike = dictionary["number_of_likes"] as? Int ?? 123
                let newsNumberComment = dictionary["number_of_comments"] as? Int ?? 123
                let newsNumberBookMark = dictionary["number_of_collection"] as? Int ?? 123
                let news: NewsModel = NewsModel(idNews: newsID,
                                                author: newsAuthor,
                                                imageUrl: newsImage,
                                                title: newsName,
                                                detail: newsDescription,
                                                type: newsType,
                                                nameType: newsNameType,
                                                content: newsContent,
                                                note: newsNote,
                                                timeUp: newsTimeup,
                                                numberView: 123,
                                                numberLike: newsNumberLike,
                                                numberComment: newsNumberComment,
                                                numberBookMark: newsNumberBookMark)
                araayNews.append(news)
            }
        }
        return araayNews
    }
}
