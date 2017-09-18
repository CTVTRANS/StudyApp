//
//  NewsInGroups.swift
//  BookApp
//
//  Created by kien le van on 9/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NewsInGroups: NSObject {
    
    private var _idNews: Int!
    private var _imageNews: String!
    private var _title: String!
    
    init(idNews: Int, image: String, title: String) {
        _idNews = idNews
        _imageNews = image
        _title = title
    }
    
    var idNews: Int {
        return _idNews
    }
    var imageURL: String {
        return _imageNews
    }
    var title: String {
        return _title
    }
}
