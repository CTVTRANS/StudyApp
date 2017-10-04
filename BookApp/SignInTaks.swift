//
//  SignInTaks.swift
//  BookApp
//
//  Created by kien le van on 10/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class SignInTaks: BaseTaskNetwork {

    private var country: Int!
    private var phone: Int!
    private var pass: String!
    
    init(countryCode: Int, phoneNumerber: Int, password: String) {
        country = countryCode
        phone = phoneNumerber
        pass = password
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func path() -> String! {
        return sigInURL
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["country_code": country, "phone_number": phone, "password": pass]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            print(dictionary)
            let status = dictionary["status"] as? String ?? " "
            let message = dictionary["message"] as? String ?? " "
            if status == "status" {
                let data = dictionary["data"] as? [String: Any]
                Constants.sharedInstance.memberProfile = paresMember(dictionary: data!)
                return (true, "sucess")
            } else {
                return (false, message)
            }
        }
        return response
    }
}
