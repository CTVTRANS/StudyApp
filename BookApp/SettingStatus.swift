//
//  Setting_Status.swift
//  BookApp
//
//  Created by kien le van on 9/27/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class SettingStatus: BaseDailog {

    var callBack:((_ status: String) -> Void) = {_ in}
    
    @IBAction func pressSingle(_ sender: Any) {
        self.hide()
        self.callBack("single")
    }
   
    @IBAction func pressedMarried(_ sender: Any) {
        self.hide()
        self.callBack("married")
    }
}
