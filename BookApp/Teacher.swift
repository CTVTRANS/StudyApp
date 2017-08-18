//
//  Teacher.swift
//  BookApp
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Teacher: NSObject {
    
    private var _name: String!
    private var _imageURL : String!
    
    init(name: String, imageURL: String) {
        _name = name
        _imageURL = imageURL
    }

}
