//
//  Vip.swift
//  BookApp
//
//  Created by kien le van on 9/15/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Vip: NSObject {

    private var _id: Int!
    private var _title: String!
    private var _imageURL: String!
    private var _description: String!
    private var _content: String!
    private var _price: Int!
    
    init(id: Int, title: String, imageURL: String, description: String, content: String, price: Int) {
        _id = id
        _title = title
        _imageURL = imageURL
        _description = description
        _content = content
        _price = price
    }
    var id: Int {
        return _id
    }
    var title: String {
        return _title
    }
    var imageURL: String {
        return _imageURL
    }
    var descriptionVip: String {
        return _description
    }
    var conten: String {
        return _content
    }
    var price: Int {
        return _price
    }
}
