//
//  SendCommentTask.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class SendCommentTask: BaseTaskNetwork {
    var _commentType: Int
    var _memberID: Int
    var _objectID: Int
    var _content: String
    
    init(commentType: Int, memberID: Int, objectId: Int, content: String) {
        _commentType = commentType
        _memberID = memberID
        _objectID = objectId
        _content = content
    }

    override func path() -> String! {
        return sendComment
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["comment_type": _commentType, "member_id": _memberID, "object_id": _objectID, "content": _content]
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}