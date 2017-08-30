//
//  LikeTask.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class LikeTask: BaseTaskNetwork {
    var _likeType: Int
    var _memberID: Int
    var _objectID: Int
    
    init(likeType: Int, memberID: Int, objectId: Int) {
        _likeType = likeType
        _memberID = memberID
        _objectID = objectId
    }
    
    override func path() -> String! {
        return likeUnlike
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["like_type": _likeType, "member_id": _memberID, "object_id": _objectID]
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            if dictionary["data"] != nil {
                return Like.LIKE
            } else {
                return Like.UNLIKE
            }
        }
        return response
    }
}
