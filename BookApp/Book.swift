//
//  Book.swift
//  BookApp
//
//  Created by kien le van on 8/15/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Book {
    
    private var _id: Int!
    private var _type: Int!
    private var _typeName: String!
    private var _nameBook: String!
    private var _author: String!
    private var _imageBookUrl: String!
    private var _numberHumanReaded: Int!
    private var _timeUpBook: String!
    private var _audio: String!
    private var _video: String!
    private var _content: String!
    private var _desCription: String!
    private var _numberLike: Int!
    private var _numberComment: Int!
    private var _numberBookMark: Int!
    
    init(id: Int,
         type: Int,
         typeName: String,
         name: String,
         author: String,
         imageUrl: String,
         numberReaded: Int,
         timeUp: String,
         audio: String,
         video: String,
         content: String,
         numberLike: Int,
         numberComment: Int,
         numberBookMark: Int,
         desCription: String ) {
        _id = id
        _type = type
        _typeName = typeName
        _nameBook = name
        _imageBookUrl = imageUrl
        _numberHumanReaded = numberReaded
        _timeUpBook = timeUp
        _audio = audio
        _video = video
        _numberLike = numberLike
        _numberComment = numberComment
        _numberBookMark = numberBookMark
        _author = author
        _content = content
        _desCription = desCription
    }
    var type: Int {
        get {
            return _type
        }
    }
    var name: String {
        get {
            return _nameBook!
        }
    }
    var typeName: String {
        get {
            return _typeName
        }
    }
    var author: String {
        get {
            return _author!
        }
    }
    var imageURL: String {
        get {
            return _imageBookUrl!
        }
    }
    
    var numberHumanReaed: Int {
        get {
            return _numberHumanReaded!
        }
        set {
            _numberHumanReaded = newValue
        }
    }
    var numberLike: Int {
        get {
            return _numberLike
        }
        set {
            _numberLike = newValue
        }
    }
    var numberComment: Int {
        get {
            return _numberComment
        }
        set {
            _numberComment = newValue
        }
    }
    var numberBookMark: Int {
        get {
            return _numberBookMark
        }
    }
    var timeUpBook: String {
        get {
            return _timeUpBook!
        }
    }
    var id: Int {
        get {
            return _id!
        }
    }
    var audio : String {
        get {
            return _audio!
        }
    }
    var video: String {
        get {
            return _video!
        }
    }
    var content: String {
        get {
            return _content!
        }
    }
    var description: String {
        get {
            return _desCription!
        }
    }
}
