//
//  ScrectGroup.swift
//  BookApp
//
//  Created by kien le van on 9/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class SecrectGroup: NSObject {
    
    private var _idGroup: Int!
    private var _name: String!
    private var _imageURL: String!
    private var _idWechat: String!
    private var _adress: String!
    
    init(idGroup: Int, name: String, imageURL: String, idWechat: String, adress: String) {
        _idGroup = idGroup
        _name = name
        _imageURL = imageURL
        _idWechat = idWechat
        _adress = adress
    }
    
    var idGroup: Int {
        return _idGroup
    }
    var name: String {
        return _name
    }
    var imageURL: String {
        return _imageURL
    }
    var idWechat: String {
        return _idWechat
    }
    var adress: String {
        return _adress
    }
}
