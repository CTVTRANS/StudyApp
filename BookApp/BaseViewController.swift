//
//  BaseViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class BaseViewController: UIViewController {
    
    var activity: UIActivityIndicatorView?
    var backGroundview: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func requestWithTask(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.request(blockSucess: { (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func downloadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.downloadFileSuccess({ (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
//    func parseBook(dictionary: [String: Any]) -> Book {
//        let idBook = dictionary["post_id"] as? Int ?? 999
//        let idTypeBook = dictionary["cat_id"] as? Int ?? 123
//        let nameTypeBook = dictionary["cat_name"] as? String ?? "123"
//        let nameBook = dictionary["post_name"] as? String ?? "123"
//        let authorBook = dictionary["author"] as? String ?? "23"
//        let imageURLBook = dictionary["post_image"] as? String ?? "123"
//        let descriptionBook = dictionary["post_description"] as? String ?? "123"
//        let audioBook = dictionary["post_audio"] as? String ?? "123"
//        let videoBook = dictionary["post_video"] as? String ?? "123"
//        let contentBook = dictionary["post_content"] as? String ?? "abc"
//        let timeUpBook = dictionary["updated_at"] as? String ?? "123"
//        let numberLikeBook = dictionary["number_of_likes"] as? Int ?? 123
//        let numberCommentBook = dictionary["number_of_comments"] as? Int ?? 123
//        
//        let book: Book = Book(id: idBook,
//                              type: idTypeBook,
//                              typeName: nameTypeBook,
//                              name: nameBook,
//                              author: authorBook,
//                              imageUrl: imageURLBook,
//                              numberReaded: 123,
//                              timeUp: timeUpBook,
//                              audio: audioBook,
//                              video: videoBook,
//                              content: contentBook,
//                              numberLike: numberLikeBook,
//                              numberComment: numberCommentBook,
//                              numberBookMark: 123,
//                              desCription: descriptionBook)
//        return book
//    }
    
    func showActivity(inView myView: UIView) {
//        backGroundview = UIView(frame: UIScreen.main.bounds)
        backGroundview = UIView(frame: myView.frame)
        backGroundview?.backgroundColor = UIColor.white
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView.backgroundColor = UIColor.clear
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingView.addSubview(activity!)
        let nameLoading = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        nameLoading.font = UIFont(name: "Helvetica Neue", size: 15)
        nameLoading.text = "loading..."
        nameLoading.textAlignment = .center
        nameLoading.textColor = UIColor.gray
        nameLoading.backgroundColor = UIColor.clear
        nameLoading.translatesAutoresizingMaskIntoConstraints = true
        loadingView.addSubview(nameLoading)
        
        backGroundview?.addSubview(loadingView)
        nameLoading.center = CGPoint(x: loadingView.center.x, y: loadingView.center.y + 23)
        activity?.center = loadingView.center
        loadingView.center = (backGroundview?.center)!
        myView.addSubview(backGroundview!)
//        UIApplication.shared.keyWindow?.addSubview(backGroundview!)
        activity?.startAnimating()
    }
    
    func stopActivityIndicator() {
        activity?.stopAnimating()
        backGroundview?.removeFromSuperview()
    }
}


