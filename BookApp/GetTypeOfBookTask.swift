//
//  GetBookTask.swift
//  BookApp
//
//  Created by kien le van on 8/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetTypeOfBookTask: BaseTaskNetwork {

    override func path() -> String! {
        return getBookTypeURL
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": "1"]
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listType = [BookType]()
        if let listObject = response as? [[String: Any]] {
            for dictionary in listObject {
                let typeBook: BookType = BookType(name: "", image: "", typeID: 0, description: "")
                typeBook.name = dictionary["cat_name"] as? String ?? ""
                typeBook.imageURL = dictionary["cat_image"] as? String ?? ""
                typeBook.typeID = dictionary["cat_id"] as? Int ?? 0
                typeBook.descriptionType = dictionary["cat_description"] as? String ?? ""
                listType.append(typeBook)
            }
        }
        Constants.sharedInstance.listBookType = listType
        return response
    }
}
