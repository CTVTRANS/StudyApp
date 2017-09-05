//
//  Teacher.swift
//  BookApp
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Chanel: NSObject {
    
    private var _nameChanel: String!
    private var _imageChanelURL : String!
    private var _typeChanel: String!
    private var _imageTeacherURL: String!
    private var _nameTeahcer: String!
    private var _idChanel: Int!
    
    
    init(idChanel: Int,
         nameChanel: String,
         imageChanelURL: String,
         typeChanel: String,
         nameTeacher: String,
         imageTeacherURL: String) {
            _idChanel = idChanel
            _nameChanel = nameChanel
            _imageChanelURL = imageChanelURL
            _typeChanel = typeChanel
            _nameTeahcer = nameTeacher
            _imageTeacherURL = imageTeacherURL
    }
    var nameChanel: String {
        return _nameChanel
    }
    var idChanel : Int {
        return _idChanel
    }
    var typeChanel: String {
        return _typeChanel
    }
    var imageChanelURL: String {
        return _imageChanelURL
    }
    var nameTeacher: String {
        return _nameTeahcer
    }
    var imageTeacherURL: String {
        return _imageTeacherURL
    }

}
