//
//  GetNewsInGroupTask.swift
//  BookApp
//
//  Created by kien le van on 9/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetNewsInGroupTask: BaseTaskNetwork {
    
    private var _idGroup: Int!
    private var _limit: Int!
    private var _page: Int!
    
    init(idGroup: Int, limit: Int, page: Int) {
        _idGroup = idGroup
        _limit = limit
        _page = page
    }
    
    override func path() -> String! {
        return getListNewsInGroupURL
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["group_id": _idGroup, "limit": _limit, "page": _page]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listPost = [NewsInGroups]()
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let idNews = dictionary["id"] as? Int ?? 1234
                let imageURL = dictionary["image"] as? String ?? "123"
                let title = dictionary["description"] as? String ?? "123"
                let news = NewsInGroups(id: idNews, image: imageURL, title: title)
                listPost.append(news)
            }
        }
        return listPost
    }
}
