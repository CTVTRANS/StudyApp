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
    case news = 0, book, comment
}

enum Like: Int {
    case unLike = 0, like
}

enum BottomButton: Int {
    case back = 0, download, bookMark, like, comment
}

class Constants: NSObject {
    var listBookType: [BookType]?
    var language: Int = 1
    static let sharedInstance = Constants()
}
