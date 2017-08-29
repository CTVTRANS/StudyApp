//
//  Comment.swift
//  BookApp
//
//  Created by kien le van on 8/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Comment: NSObject {
    private var _userComment: User!
    private var _timeComment: String!
    private var _numberLikeComment: String!
    private var _contentComment: String!

    init(user: User, time: String, numberlikeComment: String, content: String) {
        _userComment = user
        _timeComment = time
        _numberLikeComment = numberlikeComment
        _contentComment = content
    }
    var userComment: User {
        get {
            return _userComment
        }
        set {
            _userComment = newValue
        }
    }
    var timeComment: String {
        get {
            return _timeComment
        }
        set {
            _timeComment = newValue
        }
    }
    var numberLikeComment: String {
        get {
            return _numberLikeComment
        }
        set {
            _numberLikeComment = newValue
        }
    }
    var contentComment: String {
        get {
            return _contentComment
        }
        set {
            _contentComment = newValue
        }
    }
}
