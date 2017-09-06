//
//  Teacher.swift
//  BookApp
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Chanel: NSObject {
    
    private var _nameChanel, _imageChanelURL, _timeUp: String!
    private var _typeChanel: String!
    private var _imageTeacherURL, _nameTeahcer: String!
    private var _idChanel, _numberView: Int!
    
    
    init(idChanel: Int,
         nameChanel: String,
         imageChanelURL: String,
         typeChanel: String,
         nameTeacher: String,
         imageTeacherURL: String,
         numberView: Int,
         time: String) {
            _idChanel = idChanel
            _nameChanel = nameChanel
            _imageChanelURL = imageChanelURL
            _typeChanel = typeChanel
            _nameTeahcer = nameTeacher
            _imageTeacherURL = imageTeacherURL
            _numberView = numberView
            _timeUp = time
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
    var time: String {
        return _timeUp
    }
    var numberView: Int {
        get {
            return _numberView
        }
        set {
            _numberView = newValue
        }
    }

}
