//
//  BookType.swift
//  BookApp
//
//  Created by kien le van on 8/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookType: NSObject {
    private var _nameType: String!
    private var _imageType: String!
    private var _typeID: Int
    private var _descriptionType: String!
    
    init(name: String, image: String, typeID: Int, description: String) {
        _nameType = name
        _imageType = image
        _typeID = typeID
        _descriptionType = description
    }
    var name: String {
        get {
            return _nameType
        }
    }
    var imageURL: String {
        get {
            return _imageType
        }
    }
    var typeID: Int {
        get {
            return _typeID
        }
    }
    var descriptionType: String {
        get {
            return _descriptionType
        }
    }
}
