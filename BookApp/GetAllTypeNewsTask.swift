//
//  GetAllTypeNewsTask.swift
//  BookApp
//
//  Created by kien le van on 9/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetAllTypeNewsTask: BaseTaskNetwork {

    override func path() -> String! {
        return getAllTypeNewsURL
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["lang": Constants.sharedInstance.language]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listTypeNew: [NewsType] = []
        if let object = response as? [[String: Any]] {
            for dictionary in object {
                let idType = dictionary["cat_id"] as? Int ?? 1234
                let nameType = dictionary["cat_name"] as? String ?? "adfa"
                let descriptionType = dictionary["cat_description"] as? String ?? "asdf"
                let type: NewsType = NewsType(idType: idType,
                                              nameType: nameType,
                                              desciptionType: descriptionType)
                listTypeNew.append(type)
            }
        }
        Constants.sharedInstance.listNewsType = listTypeNew
        return response
    }
}
