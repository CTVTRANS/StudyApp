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
        setupCallBackButton()
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
        setupUI()
        bodyNews.delegate = self
        bodyNews.scrollView.isScrollEnabled = false
        
        detailNews.text = "down voteThe easiest way, IMO, is just to click on the title bar of the first ViewController and in the Attribute Inspector (⌥+⌘+4) change the Navigation Item info the way you want: Title -> what will show up in the back button* or if you want it to say something other than the Title of the first ViewController or the word Back you can just put it in the Back Button field."
    }
    
    func setupUI() {
         bodyNews.loadHTMLString(news.content, baseURL: nil)
        imageNews.sd_setImage(with: URL(string: news.imageURL))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightContentWeb: CGFloat = bodyNews.scrollView.contentSize.height
        print(hightContentWeb)
        hightOfWebView.constant = hightContentWeb
        scroll.contentSize.height = hightContentWeb + 197
    }
    
    private func setupCallBackButton() {
        bottomView.downloadImage.isHidden = true
        bottomView.downloadButton.isHidden = true
        bottomView.numberLike.text = String(news.numberLike)
        bottomView.numberComment.text = String(news.numberComment)
        
        bottomView.pressBackButton = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        bottomView.pressedComment = { [weak self] in
            let storyboard = UIStoryboard(name: "Global", bundle: nil)
            let vc: CommentController = storyboard.instantiateViewController(withIdentifier: "CommentController") as! CommentController
            vc.idObject = self?.news.id
            vc.commentType = 0
            self?.present(vc, animated: true, completion: nil)
        }
        bottomView.pressedLike = { [weak self] in
            let likeTask: LikeTask = LikeTask(likeType: 0, memberID: 1, objectId: self!.news.id)
            self?.requestWithTask(task: likeTask, success: { (data) in
                print(data!)
            }, failure: { (error) in
                
            })
        }
        bottomView.pressedBookMark = {
            print("bookmark")
        }
        bottomView.pressedDownload = {
            print("download")
        }
    }
    
    @objc private func share() {
        print("share")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
