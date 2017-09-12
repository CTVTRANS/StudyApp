//
//  GetProfileMemberTask.swift
//  BookApp
//
//  Created by kien le van on 9/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class GetProfileMemberTask: BaseTaskNetwork {
    
//    _id = id
//    _memberCode = memberCode
//    _level = level
//    _name = name
//    _country = country
//    _phoneNumber = phoneNumber
//    _email = email
//    _avatar = avatar
//    _sex = sex
//    _dateOfBirth = birDay
//    _job = job
//    _marriage = marriage
//    _hobby = hobby
//    _poit = point

    private var _memberID: Int!
    
    init(id: Int) {
        _memberID = id
    }
    
    override func path() -> String! {
        return getProfileMemberURL
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["member_id": _memberID]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            let memberID = dictionary["id"] as? Int ?? 9999
            let memberCode = dictionary["member_code"] as? String ?? "123456"
            let memberLevel = dictionary["level"] as? Int ?? 0
            let memberName = dictionary["name"] as? String ?? "asdf"
            let memberCountry = dictionary["country_code"] as? String ?? " "
            let memberPhone = dictionary["phone_number"] as? String ?? " "
            let memberEmail = dictionary["email"] as? String ?? " "
            let memberAvatar = dictionary["avatar"] as? String ?? " "
            let memberSex = dictionary["gender"] as? Int ?? 9999
            let memberBirthDay = dictionary["date_of_birth"] as? String ?? " "
            let memberJob = dictionary["job"] as? String ?? " "
            let memberMarri = dictionary["marriage"] as? String ?? " "
            let memberHobby = dictionary["hobby"] as? String ?? " "
            let memberPoint = dictionary["point"] as? Int ?? 9999
            
            let member: ProfileMember = ProfileMember(id: memberID,
                                                      memberCode: memberCode,
                                                      level: memberLevel,
                                                      name: memberName,
                                                      country: memberCountry,
                                                      phoneNumber: memberPhone,
                                                      email: memberEmail,
                                                      avatar: memberAvatar,
                                                      sex: memberSex,
                                                      birDay: memberBirthDay,
                                                      job: memberJob,
                                                      marriage: memberMarri,
                                                      hobby: memberHobby,
                                                      point: memberPoint)
            Constants.sharedInstance.memberProfile = member
        }
        return true
    }
}
