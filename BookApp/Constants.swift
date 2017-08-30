//
//  Constants.swift
//  BookApp
//
//  Created by Le Cong on 8/11/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

let widthScreen: CGFloat = UIScreen.main.bounds.width
let hightScreen: CGFloat = UIScreen.main.bounds.height

enum Object: Int{
    case NEWS = 0, BOOK, COMMENT
}

enum Like: Int {
    case UNLIKE = 0, LIKE
}

class Constants: NSObject {
    var listBookType: [BookType]?
    var language: Int!
    static let sharedInstance = Constants()
}
