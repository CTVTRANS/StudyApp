//
//  Type2DetailNewsViewController.swift
//  BookApp
//
//  Created by kien le van on 8/23/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Type2DetailNewsViewController: BaseViewController {

    @IBOutlet weak var viewBounds: UIView!
    @IBOutlet weak var bottomView: BottomView!
    @IBOutlet weak var timeUp: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var webContent: UIWebView!
    @IBOutlet weak var newsName: UILabel!
    var news: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        let checkLiked: CheckLikedTask = CheckLikedTask(likeType: Object.news.rawValue,
                                                        memberID: 1,
                                                        objectID: news.id)
        requestWithTask(task: checkLiked, success: { [weak self] (data) in
            let status: Bool = data as! Bool
            if status {
                self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_liked")
            } else {
                self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_like")
            }
        }) { (error) in
            
        }
        let checkBookMarked: CheckBookMarkedTask = CheckBookMarkedTask(bookMarkType: Object.news.rawValue,
                                                                       memberID: 1,
                                                                       objectID: news.id)
        requestWithTask(task: checkBookMarked, success: { [weak self] (data) in
            let status: Bool = data as! Bool
            if status {
                self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMarked")
            } else {
                self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMark")
            }
        }) { (error) in
            
        }
        setupUI()
        viewBounds.layer.borderColor = UIColor.rgb(r: 52, g: 52, b: 52).cgColor
        setupCallBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: news.title,
                            style: .done,
                            target: self,
                            action: nil)
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"),
                            style: .plain,
                            target: self,
                            action: #selector(share))
    }
    
    func setupUI() {
        newsName.text = news.title
        userName.text = news.author
        let date = news.timeUp.components(separatedBy: " ")
        timeUp.text = date[0]
        webContent.loadHTMLString(news.content, baseURL: nil)
        stopActivityIndicator()
    }
    
    private func setupCallBackButton() {
        bottomView.downloadButton.isHidden = true
        bottomView.downloadImage.isHidden = true
        bottomView.numberLike.text = String(news.numberLike)
        bottomView.numberComment.text = String(news.numberComment)
        bottomView.numberBookmark.text = String(news.numberBookMark)
        
        bottomView.pressedBottomButton = { [weak self] (typeButotn: BottomButton) in
            switch typeButotn {
            case BottomButton.back:
                 self?.navigationController?.popViewController(animated: true)
            case BottomButton.bookMark:
                let bookMarkTask: BookMarkTask = BookMarkTask(bookMarkType: Object.news.rawValue,
                                                              memberID: 1,
                                                              objectId: self!.news.id)
                self?.requestWithTask(task: bookMarkTask, success: { (data) in
                    let status: BookMark = (data as? BookMark)!
                    var currentBookMark: Int = Int(self!.bottomView.numberBookmark.text!)!
                    if status == BookMark.bookMark {
                        self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMarked")
                        currentBookMark += 1
                        self?.news.numberBookMark = currentBookMark
                        self?.bottomView.numberBookmark.text = String(currentBookMark)
                    } else {
                        self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMark")
                        currentBookMark -= 1
                        self?.news.numberBookMark = currentBookMark
                        self?.bottomView.numberBookmark.text = String(currentBookMark)
                    }
                }, failure: { (error) in
                    
                })
            case BottomButton.download:
                print("download")
            case BottomButton.like:
                let likeTask: LikeTask = LikeTask(likeType: Object.news.rawValue,
                                                  memberID: 1,
                                                  objectId: self!.news.id)
                self?.requestWithTask(task: likeTask, success: { (data) in
                    let status: Like = (data as? Like)!
                    var currentLike: Int = Int(self!.bottomView.numberLike.text!)!
                    if status == Like.like {
                        self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_liked")
                        currentLike += 1
                        self?.news.numberLike = currentLike
                        self?.bottomView.numberLike.text = String(currentLike)
                    } else {
                        self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_like")
                        currentLike -= 1
                        self?.news.numberLike = currentLike
                        self?.bottomView.numberLike.text = String(currentLike)
                    }
                }, failure: { (error) in
                    
                })
            case BottomButton.comment:
                let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
                let vc: CommentController = myStoryboard.instantiateViewController(withIdentifier: "CommentController") as! CommentController
                vc.idObject = self?.news.id
                vc.commentType = 0
                self?.present(vc, animated: false, completion: nil)
            }
        }
    }

    @objc private func share() {
        print("share")
    }

}
