//
//  GetCommentHot.swift
//  BookApp
//
//  Created by kien le van on 8/31/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetCommentHot: BaseTaskNetwork {

    private let _commentType: Int!
    private let _idObject: Int!
    
    init(commentType: Int, idObject: Int) {
        _commentType = commentType
        _idObject = idObject
    }
    
    override func path() -> String! {
        return getAllCommentURL
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["comment_type": _commentType,
                "object_id": _idObject]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listComment = [Comment]()
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let iDComment = dictionary["comment_id"] as? Int ?? 999
                let contentcomment = dictionary["comment_content"] as? String ?? "999"
                let timeComment = dictionary["comment_time"] as? String ?? "999"
                let numberLikeComment = dictionary["number_of_likes"] as? Int ?? 999
                let userName = dictionary["author_name"] as? String ?? "kien"
                let userAvata = dictionary["author_avatar"] as? String ?? "999"
                let user: User = User(name: userName, age: 18, sex: 1, avata: userAvata)
                let commentObject: Comment = Comment(idComment: iDComment,
                                                     user: user,
                                                     time: timeComment,
                                                     numberlikeComment: numberLikeComment,
                                                     content: contentcomment)
                listComment.append(commentObject)
            }
        }
        return listComment
    }
}
