//
//  BaseExtendtion.swift
//  Weding
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import DeviceKit
import LCNetwork

class BaseViewcontrollerExtend: NSObject {

}

extension BaseTaskNetwork {
    func parseBook(dictionary: [String: Any]) -> Book {
        let idBook = dictionary["post_id"] as? Int ?? 999
        let idTypeBook = dictionary["cat_id"] as? Int ?? 123
        let nameTypeBook = dictionary["cat_name"] as? String ?? "123"
        let nameBook = dictionary["post_name"] as? String ?? "123"
        let authorBook = dictionary["author"] as? String ?? "23"
        let imageURLBook = dictionary["post_image"] as? String ?? "123"
        let descriptionBook = dictionary["post_description"] as? String ?? "123"
        let audioBook = dictionary["post_audio"] as? String ?? "123"
        let videoBook = dictionary["post_video"] as? String ?? "123"
        let contentBook = dictionary["post_content"] as? String ?? "abc"
        let timeUpBook = dictionary["updated_at"] as? String ?? "123"
        let numberLikeBook = dictionary["number_of_likes"] as? Int ?? 123
        let numberCommentBook = dictionary["number_of_comments"] as? Int ?? 123
        let book: Book = Book(id: idBook,
                              type: idTypeBook,
                              typeName: nameTypeBook,
                              name: nameBook,
                              author: authorBook,
                              imageUrl: imageURLBook,
                              numberReaded: 123,
                              timeUp: timeUpBook,
                              audio: audioBook,
                              video: videoBook,
                              content: contentBook,
                              numberLike: numberLikeBook,
                              numberComment: numberCommentBook,
                              numberBookMark: 123,
                              desCription: descriptionBook)
        return book
    }
}

extension UILabel {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s) {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension UITextField {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s) {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension NSLayoutConstraint {
    var adjustConstantToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentConstant = self.constant
                var sizeScale: CGFloat = 1
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                        || device == .simulator(.iPhone7Plus)
                        || device == .iPhone6Plus
                        || device == .iPhone7Plus
                        || device == .iPhone6s) {
                    sizeScale = 1.3
                }
                self.constant = currentConstant * sizeScale
            }
        }
        get {
            return false
        }
    }
}

extension UIButton {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.titleLabel?.font
                var sizeScale: CGFloat = 1
//                let model = UIDevice.current.model
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s) {
                    sizeScale = 1.3
                }
//                if model == "iPhone 6" {
//                    sizeScale = 1.3
//                }
//                else if model == "iPhone 6 Plus" {
//                    sizeScale = 1.5
//                }
                self.titleLabel?.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        
        get {
            return false
        }
    }
}

extension CGFloat {
   var adjustsSizeToRealIPhoneSize: CGFloat {
        set {
            var sizeScale: CGFloat = 1
            let device = Device()
            if (device == .simulator(.iPhone7)
                || device == .simulator(.iPhone6)
                || device == .iPhone6
                || device == .iPhone7) {
                sizeScale = 1.2
            } else if (device == .simulator(.iPhone6Plus)
                || device == .simulator(.iPhone7Plus)
                || device == .iPhone6Plus
                || device == .iPhone7Plus
                || device == .iPhone6s) {
                sizeScale = 1.3
            }
            self = newValue * sizeScale

        }
        get {
            return self
        }
    }
}

extension UITabBarControllerDelegate {
    public func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        let fromView: UIView = tabBarController.selectedViewController!.view
        let toView  : UIView = viewController.view
        if fromView == toView {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: UIViewAnimationOptions.transitionCrossDissolve) { (finished:Bool) in
            
        }
        return true
    }
}

extension UIColor {
    class func rgb(r: Float, g: Float, b: Float) -> UIColor {
        return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}


/*
extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
 */
