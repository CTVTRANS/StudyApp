//
//  Comment.swift
//  BookApp
//
//  Created by kien le van on 8/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Comment: NSObject {
    private var _idComment: Int!
    private var _userComment: User!
    private var _timeComment: String!
    private var _numberLikeComment: Int!
    private var _contentComment: String!

    init(idComment: Int, user: User, time: String, numberlikeComment: Int, content: String) {
        _idComment = idComment
        _userComment = user
        _timeComment = time
        _numberLikeComment = numberlikeComment
        _contentComment = content
    }
    var idComment: Int {
        return _idComment
    }
    var userComment: User {
        return _userComment
    }
    var timeComment: String {
        return _timeComment
    }
    var numberLikeComment: Int {
        get {
            return _numberLikeComment
        }
        set {
            _numberLikeComment = newValue
        }
    }
    var contentComment: String {
        return _contentComment
    }
}
