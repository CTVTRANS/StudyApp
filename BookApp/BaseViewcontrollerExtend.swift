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
        let numberBookMark = dictionary["number_of_collection"] as? Int ?? 123
        let price = dictionary["price_by_point"] as? Int ?? 0
        
        let priceMixDictionay = dictionary["price_mix"] as? [String: Any]
        let priceMix_Point = priceMixDictionay?["point"] as? Int ?? 0
        let priceMix_Money = priceMixDictionay?["money"] as? Int ?? 0
        let priceMixOfBook = PriceMix(point: priceMix_Point, money: priceMix_Money)
        
        let book: Book = Book(idBook: idBook,
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
                              numberBookMark: numberBookMark,
                              desCription: descriptionBook,
                              price: price,
                              priceMix: priceMixOfBook)
        return book
    }
    
    func parseChanel(dictionary: [String: Any]) -> Chanel {
        let chanelName = dictionary["channel_title"] as? String ?? "asd"
        let chanelID = dictionary["post_id"] as? Int ?? 123
        let chanelType = dictionary["cat_name"] as? String ?? "asd"
        let chanelImage = dictionary["channel_image"] as? String ?? "asd"
        let teacherName = dictionary["teacher_name"] as? String ?? "asd"
        let teacherImage = dictionary["teacher_image"] as? String ?? "ad"
        let chanelTimeUp = dictionary[""] as? String ?? "12-8-2017 7:34:45"
        let chanel: Chanel = Chanel(idChanel: chanelID,
                                    nameChanel: chanelName,
                                    imageChanelURL: chanelImage,
                                    typeChanel: chanelType,
                                    nameTeacher: teacherName,
                                    imageTeacherURL: teacherImage,
                                    numberView: 123,
                                    time: chanelTimeUp)
        return chanel
    }
    
    func parseLesson(dictionary: [String: Any]) -> Lesson {
        let lessonID = dictionary["id"] as? Int ?? 1234
        let lessonChapter = dictionary["chapter"] as? Int ?? 23
        let lessonName = dictionary["title"] as? String ?? "asd"
        let lessonDescription = dictionary["description"] as? String ?? "asd"
        let lessonContent = dictionary["audio"] as? String ?? "asdf"
        let  lessonTimeup = dictionary["created_at"] as? String ?? "sas"
        let lesson: Lesson = Lesson(idLesson: lessonID,
                                    chaper: lessonChapter,
                                    time: lessonTimeup,
                                    name: lessonName,
                                    description: lessonDescription,
                                    imageURL: "123",
                                    contentURL: lessonContent)
        return lesson
    }
    
    func parseGroup(dictionary: [String: Any]) -> SecrectGroup {
        let idGroup = dictionary["id"] as? Int ?? 999
        let titleGroup = dictionary["title"] as? String ?? " "
        let imageGroup = dictionary["image"] as? String ?? " "
        let idWechatGroup = dictionary["wechat"] as? String ?? " "
        let adressGroup = dictionary["address"] as? String ?? " "
        let group = SecrectGroup(idGroup: idGroup,
                                 name: titleGroup,
                                 imageURL: imageGroup,
                                 idWechat: idWechatGroup,
                                 adress: adressGroup)
        return group
    }
    
    func parseNews(dictionary: [String: Any]) -> NewsModel {
        let newsID = dictionary["post_id"] as? Int ?? 123
        let newsAuthor = dictionary["author"] as? String ?? "kien"
        let newsName = dictionary["post_name"] as? String ?? "123"
        let newsImage = dictionary["post_image"] as? String ?? "123"
        let newsDescription = dictionary["post_description"] as? String ?? "123"
        let newsContent = dictionary["post_content"] as? String ?? "123"
        let newsNote = dictionary["post_note"] as? String ?? "123"
        let newsTimeup = dictionary["updated_at"] as? String ?? "123"
        let newsType = dictionary["post_display_type"] as? Int ?? 123
        let newsNameType = dictionary["cat_name"] as? String ?? "123"
        let newsNumberLike = dictionary["number_of_likes"] as? Int ?? 123
        let newsNumberComment = dictionary["number_of_comments"] as? Int ?? 123
        let newsNumberBookMark = dictionary["number_of_collection"] as? Int ?? 123
        
        let news: NewsModel = NewsModel(idNews: newsID,
                                        author: newsAuthor,
                                        imageUrl: newsImage,
                                        title: newsName,
                                        detail: newsDescription,
                                        type: newsType,
                                        nameType: newsNameType,
                                        content: newsContent,
                                        note: newsNote,
                                        timeUp: newsTimeup,
                                        numberView: 123,
                                        numberLike: newsNumberLike,
                                        numberComment: newsNumberComment,
                                        numberBookMark: newsNumberBookMark)
        return news
    }
    
    func parseVip(dictionary: [String: Any]) -> Vip {
        let idVip = dictionary["id"] as? Int ?? 123
        let titleVip = dictionary["title"] as? String ?? "123"
        let imageVip = dictionary["image"] as? String ?? "123"
        let descriptionVip = dictionary["description"] as? String ?? "dasdf"
        let contentVip = dictionary["content"] as? String ?? "sdaf"
        let priceVip = dictionary["price"] as? Int ?? 123
        let vip = Vip(idVip: idVip,
                  title: titleVip,
                  imageURL: imageVip,
                  description: descriptionVip,
                  content: contentVip,
                  price: priceVip)
        return vip
    }
}

extension UIAlertController {
    class func showAlertWith(title: String, message: String, inViewController: UIViewController) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default) { (_) in
                                    alertView.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(action)
        inViewController.present(alertView, animated: true, completion: nil)
    }
    
    class func showActionSheetWith(arrayTitle: [String],
                                   handlerAction: @escaping ((_ index: Int) -> Void),
                                   in viewController: UIViewController) {
        let alertView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for index in 0..<arrayTitle.count {
            let action = UIAlertAction(title: arrayTitle[index],
                                       style: .default,
                                       handler: { (_) in
                handlerAction(index)
            })
            alertView.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消",
                                         style: .cancel) { (_) in
        }
        alertView.addAction(cancelAction)
        viewController.present(alertView, animated: true, completion: nil)
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

extension UILabel {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s {
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
                if device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s {
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
                if device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus)
                        || device == .simulator(.iPhone7Plus)
                        || device == .iPhone6Plus
                        || device == .iPhone7Plus
                        || device == .iPhone6s {
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
                if device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7 {
                    sizeScale = 1.2
                } else if device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s {
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
            if device == .simulator(.iPhone7)
                || device == .simulator(.iPhone6)
                || device == .iPhone6
                || device == .iPhone7 {
                sizeScale = 1.2
            } else if device == .simulator(.iPhone6Plus)
                || device == .simulator(.iPhone7Plus)
                || device == .iPhone6Plus
                || device == .iPhone7Plus
                || device == .iPhone6s {
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
        let toView: UIView = viewController.view
        if fromView == toView {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: UIViewAnimationOptions.transitionCrossDissolve) { (_: Bool) in
            
        }
        return true
    }
}

extension UIColor {
    class func rgb(red: Float, green: Float, blue: Float) -> UIColor {
        return UIColor(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}
