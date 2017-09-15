//
//  SubcribleGroupTask.swift
//  BookApp
//
//  Created by kien le van on 9/15/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class SubcribleGroupTask: BaseTaskNetwork {
    
    private var _arrayIDGroup: String!
    
    init(arryID: String) {
        _arrayIDGroup = arryID
    }
    
    override func path() -> String! {
        return subcribleGroupURL
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["member_id": 1, "object_id": _arrayIDGroup]
    }

    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}
