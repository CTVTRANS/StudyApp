//
//  ProfileMember.swift
//  BookApp
//
//  Created by kien le van on 9/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ProfileMember: NSObject {

    private var _idMember, _level, _sex, _poit: Int?
    private var _memberCode, _name, _country: String?
    private var _phoneNumber, _email, _avatar: String?
    private var _dateOfBirth, _job, _marriage, _hobby: String?
    
    init(idMember: Int, memberCode: String, level: Int, name: String, country: String,
         phoneNumber: String, email: String, avatar: String, sex: Int, birDay: String,
         job: String, marriage: String, hobby: String, point: Int) {
        _idMember = idMember
        _memberCode = memberCode
        _level = level
        _name = name
        _country = country
        _phoneNumber = phoneNumber
        _email = email
        _avatar = avatar
        _sex = sex
        _dateOfBirth = birDay
        _job = job
        _marriage = marriage
        _hobby = hobby
        _poit = point
    }
    
    var idMember: Int {
        return _idMember!
    }
    var level: Int {
        return _level!
    }
    var sex: Int? {
        get { return _sex}
        set { _sex = newValue}
    }
    var point: Int {
        return _poit!
    }
    var memberCode: String? {
        return _memberCode
    }
    var name: String {
        get { return _name!}
        set { _name = newValue}
    }
    var country: String? {
        get { return _country}
        set { _country = newValue}
    }
    var phoneNumber: String {
        get { return _phoneNumber!}
        set { _phoneNumber = newValue}
    }
    var avatar: String? {
        return _avatar
    }
    var email: String? {
        get { return _email}
        set { _email = newValue}
    }
    var dateOfBirth: String? {
        get { return _dateOfBirth}
        set { _dateOfBirth = newValue}
    }
    var job: String? {
        get { return _job}
        set { _job = newValue}
    }
    var marriage: String? {
        get { return _marriage}
        set { _marriage = newValue}
    }
    var hobby: String? {
        get { return _hobby}
        set { _hobby = newValue}
    }
}
