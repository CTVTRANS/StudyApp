//
//  NewsType.swift
//  BookApp
//
//  Created by kien le van on 9/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NewsType: NSObject {
    
    private var _idType:Int!
    private var _nameType: String!
    private var _description: String!
    
    init(idType: Int, nameType: String, desciptionType: String) {
        _idType = idType
        _nameType = nameType
        _description = desciptionType
    }

    var idType: Int {
        return _idType
    }
    var nameType: String {
        return _nameType
    }
    var descriptionType: String {
        return _description
    }
}
