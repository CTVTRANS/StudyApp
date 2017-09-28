//
//  Setting_ChooseSex.swift
//  BookApp
//
//  Created by kien le van on 9/27/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class SettingChooseSex: BaseDailog {
    
    var calBack:((_ sex: String) -> Void) = {_ in}

    @IBAction func pressedFemale(_ sender: Any) {
        self.hide()
        self.calBack("female")
    }
   
    @IBAction func pressMale(_ sender: Any) {
        self.hide()
        self.calBack("male")
    }
}
