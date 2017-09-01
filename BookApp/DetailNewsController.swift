//
//  DetailViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailNewsController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var bottomView: BottomView!
    @IBOutlet weak var bodyNews: UIWebView!
    @IBOutlet weak var detailNews: UILabel!
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var userName: UILabel!
    var news: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        setupCallBackButton()
        setupUI()
        bodyNews.delegate = self
        bodyNews.scrollView.isScrollEnabled = false
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
        detailNews.text = "你本人辦法積分是的呢in側in承認ID粗任汝芬ID那你發就差你的不斷得到或單位違反in方式就呵呵你吃的雞年大吉收到那個農村拆除"
    }
    
    func setupUI() {
        userName.text = news.author
        bodyNews.loadHTMLString(news.content, baseURL: nil)
        imageNews.sd_setImage(with: URL(string: news.imageURL))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightContentWeb: CGFloat = bodyNews.scrollView.contentSize.height
        hightOfWebView.constant = hightContentWeb
        stopActivityIndicator()
    }
    
    private func setupCallBackButton() {
        bottomView.downloadImage.isHidden = true
        bottomView.downloadButton.isHidden = true
        bottomView.numberLike.text = String(news.numberLike)
        bottomView.numberComment.text = String(news.numberComment)
        
        bottomView.pressedBottomButton = { [weak self] (typeButton: BottomButton) in
            switch typeButton {
            case BottomButton.back:
                 self?.navigationController?.popViewController(animated: true)
            case BottomButton.comment:
                let storyboard = UIStoryboard(name: "Global", bundle: nil)
                let vc: CommentController = storyboard.instantiateViewController(withIdentifier: "CommentController") as! CommentController
                vc.idObject = self?.news.id
                vc.commentType = 0
                self?.present(vc, animated: false, completion: nil)
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
            case BottomButton.bookMark:
                let storyboard = UIStoryboard(name: "Global", bundle: nil)
                let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "Login") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case BottomButton.download:
                print("download")
            }
        }
    }
    
    @objc private func share() {
        print("share")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
