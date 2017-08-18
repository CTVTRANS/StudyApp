//
//  Book.swift
//  BookApp
//
//  Created by kien le van on 8/15/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Book {
    
    private var _nameBook: String?
    private var _imageBookUrl: String?
    private var _numberHumanReaded: String?
    private var _timeUpBook: String?

    var nameBook: String {
        get {
            return self._nameBook!
        }
        set {
            self._nameBook = newValue
        }
    }
    
    var imageBookUrl: String {
        get {
            return self._imageBookUrl!
        }
        set {
            self._imageBookUrl  = newValue
        }
    }
    
    var numberHumanReaed: String {
        get {
            return self._numberHumanReaded!
        }
        set {
            self._numberHumanReaded = newValue
        }
    }
    
    var timeUpBook: String {
        get {
            return self._timeUpBook!
        }
        set {
            self._timeUpBook = newValue
        }
    }
    
    init(name: String, imageUrl: String, numberReaded: String, timeUp: String) {
        self._nameBook = name
        self._imageBookUrl = imageUrl
        self._numberHumanReaded = numberReaded
        self._timeUpBook = timeUp
    }
    
}
