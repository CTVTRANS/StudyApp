//
//  Constants.swift
//  BookApp
//
//  Created by Le Cong on 8/11/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Constants: NSObject {
    

}

extension UIColor {
    class func rgb(r: Float, g: Float, b: Float) -> UIColor {
        return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
