//
//  NewsInGroups.swift
//  BookApp
//
//  Created by kien le van on 9/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NewsInGroups: NSObject {
    
    private var _id: Int!
    private var _imageNews: String!
    private var _title: String!
    
    init(id: Int, image: String, title: String) {
        _id = id
        _imageNews = image
        _title = title
    }
    
    var id: Int {
        return _id
    }
    var imageURL: String {
        return _imageNews
    }
    var title: String {
        return _title
    }
}
