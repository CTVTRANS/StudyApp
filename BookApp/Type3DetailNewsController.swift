//
//  Type3DetailNewsController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import Social

class Type3DetailNewsController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var bottomView: BottomView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UIWebView!
    @IBOutlet weak var note: UIWebView!
    
    @IBOutlet weak var highOfNoteView: NSLayoutConstraint!
    var news: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        note.delegate = self
        let checkLiked: CheckLikedTask = CheckLikedTask(likeType: Object.news.rawValue,
                                                        memberID: 1,
                                                        objectID: news.idNews)
        requestWithTask(task: checkLiked, success: { [weak self] (data) in
            if let status = data as? Bool {
                if status {
                    self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_liked")
                } else {
                    self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_like")
                }
            }
        }) { (_) in
            
        }
        let checkBookMarked: CheckBookMarkedTask = CheckBookMarkedTask(bookMarkType: Object.news.rawValue,
                                                                       memberID: 1,
                                                                       objectID: news.idNews)
        requestWithTask(task: checkBookMarked, success: { [weak self] (data) in
            if let status = data as? (Bool, Int) {
                if status.0 {
                    self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMarked")
                } else {
                    self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMark")
                }
                self?.news.numberBookMark = status.1
                self?.bottomView.numberBookmark.text = String(status.1)
            }
        }) { (_) in
            
        }
        setupCallBackButton()
        author.text = news.author
        content.loadHTMLString(news.content, baseURL: nil)
        note.loadHTMLString(news.note, baseURL: nil)
        let time = news.timeUp.components(separatedBy: " ")
        date.text = time[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: news.title,
                            style: .done,
                            target: self,
                            action: nil)
        setupRightSlideOut()
    }

    func setupCallBackButton() {
        bottomView.downloadButton.isHidden = true
        bottomView.downloadImage.isHidden = true
        bottomView.numberLike.text = String(news.numberLike)
        bottomView.numberComment.text = String(news.numberComment)
        
        bottomView.pressedBottomButton = { [weak self] (typeButotn: BottomButton) in
            switch typeButotn {
            case BottomButton.back:
                self?.navigationController?.popViewController(animated: true)
            case BottomButton.bookMark:
                self?.pressedBookmark()
            case BottomButton.download:
                print("download")
            case BottomButton.like:
                self?.pressedLike()
            case BottomButton.comment:
                let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "CommentController") as? CommentController {
                    vc.idObject = self?.news.idNews
                    vc.commentType = 0
                    self?.present(vc, animated: false, completion: nil)
                }
            }
        }
    }
    
    func pressedLike() {
        let likeTask: LikeTask = LikeTask(likeType: Object.news.rawValue,
                                          memberID: 1,
                                          objectId: self.news.idNews)
        self.requestWithTask(task: likeTask, success: { (data) in
            let status: Like = (data as? Like)!
            var currentLike: Int = Int(self.bottomView.numberLike.text!)!
            if status == Like.like {
                self.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_liked")
                currentLike += 1
                self.news.numberLike = currentLike
                self.bottomView.numberLike.text = String(currentLike)
            } else {
                self.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_like")
                currentLike -= 1
                self.news.numberLike = currentLike
                self.bottomView.numberLike.text = String(currentLike)
            }
        }, failure: { (_) in
            
        })
    }
    
    func pressedBookmark() {
        let bookMarkTask: BookMarkTask = BookMarkTask(bookMarkType: Object.news.rawValue,
                                                      memberID: 1,
                                                      objectId: news.idNews)
        self.requestWithTask(task: bookMarkTask, success: { (data) in
            let status: BookMark = (data as? BookMark)!
            var currentBookMark: Int = Int(self.bottomView.numberBookmark.text!)!
            if status == BookMark.bookMark {
                self.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMarked")
                currentBookMark += 1
                self.news.numberBookMark = currentBookMark
                self.bottomView.numberBookmark.text = String(currentBookMark)
            } else {
                self.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMark")
                currentBookMark -= 1
                self.news.numberBookMark = currentBookMark
                self.bottomView.numberBookmark.text = String(currentBookMark)
            }
        }, failure: { (_) in
            
        })
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightNew = note.scrollView.contentSize.height
        highOfNoteView.constant = hightNew
        stopActivityIndicator()
    }

}
