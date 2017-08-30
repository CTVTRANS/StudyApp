//
//  NewsModel.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    private var _id: Int!
    private var _author: String!
    private var _imageURL: String!
    private var _titleNews: String!
    private var _detailTitle: String!
    private var _typeNews: Int!
    private var _content: String!
    private var _timeUp: String!
    private var _numberViewNews: Int!
    private var _numberLikeNews: Int!
    private var _numberCommentNews: Int!
    private var _numberBookMarkNews: Int!
    
    init(id: Int, author: String, imageUrl: String, title: String,
         detail: String, type: Int, content: String,
         timeUp: String, numberView: Int, numberLike: Int,
         numberComment: Int, numberBookMark: Int) {
        _id = id
        _author = author
        _imageURL = imageUrl
        _titleNews = title
        _detailTitle = detail
        _typeNews = type
        _content = content
        _timeUp = timeUp
        _numberViewNews = numberView
        _numberLikeNews = numberLike
        _numberCommentNews = numberComment
        _numberBookMarkNews = numberBookMark
    }
    var id: Int {
        get {
            return _id
        }
    }
    var author: String {
        get {
            return _author
        }
    }
    var imageURL: String {
        get {
            return _imageURL
        }
    }
    var title: String {
        get {
            return _titleNews
        }
    }
    var detailNews: String {
        get {
            return _detailTitle
        }
    }
    var typeNews: Int {
        get {
            return _typeNews
        }
    }
    var content: String {
        get {
            return _content
        }
    }
    var timeUp: String {
        get {
            return _timeUp
        }
    }
    var numberViewNews: Int {
        get {
            return _numberViewNews
        }
        set {
            _numberViewNews = newValue
        }
    }
    var numberLike: Int {
        get {
            return _numberLikeNews
        }
        set {
            _numberLikeNews = newValue
        }
    }
    var numberComment: Int {
        get {
            return _numberCommentNews
        }
        set {
            _numberCommentNews = newValue
        }
    }
    var bookMark: Int {
        get {
            return _numberBookMarkNews
        }
        set {
            _numberBookMarkNews = newValue
        }
    }
}
