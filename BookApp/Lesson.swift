//
//  Lesson.swift
//  BookApp
//
//  Created by kien le van on 9/5/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Lesson: NSObject {
    
    private let _idLesson, _chapter: Int!
    private let _timeUp: String!
    private let _name, _description: String!
    private let _imageChapterURL, _contentChapterURL: String!
    private var _isPlay: Int = 0
    private var _pause: Int = 0
    private var _ownerOFChanel: String?
    
    init(idLesson: Int, chaper: Int, time: String, name: String, description: String,
         imageURL: String, contentURL: String) {
        _idLesson = idLesson
        _chapter = chaper
        _timeUp = time
        _name = name
        _description = description
        _imageChapterURL = imageURL
        _contentChapterURL = contentURL
    }
    var idChap: Int {
        return _idLesson
    }
    var chapter: Int {
        return _chapter
    }
    var timeUp: String {
        return _timeUp
    }
    var name: String {
        return _name
    }
    var descriptionChap: String {
        return _description
    }
    var imageChapURL: String {
        return _imageChapterURL
    }
    var contentURL: String {
        return _contentChapterURL
    }
    var isPlay: Int {
        get {
            return _isPlay
        }
        set {
            _isPlay = newValue
        }
    }
    var pause: Int {
        get {
            return _pause
        }
        set {
            _pause = newValue
        }
    }
    var chanelOwner: String {
        get {
            return _ownerOFChanel!
        }
        set {
            _ownerOFChanel = newValue
        }
    }
}
