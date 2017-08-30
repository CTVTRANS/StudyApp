//
//  ActivityView.swift
//  BookApp
//
//  Created by kien le van on 8/30/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ActivityView: UIView {
    
    var activity: UIActivityIndicatorView?
    var backGroundview: UIView?
    
    func showActivity(with: String) {
        backGroundview = UIView(frame: UIScreen.main.bounds)
    }
   
}
