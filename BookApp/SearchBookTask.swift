//
//  SearchTask.swift
//  BookApp
//
//  Created by kien le van on 9/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class SearchBookTask: BaseTaskNetwork {

    private var _keyWord: String!
    private var _limit: Int!
    private var _page: Int!
    
    init(keyWord: String, limit: Int, page: Int) {
        _keyWord = keyWord
        _limit = limit
        _page = page
    }
}
