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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBackButton()
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "ok",
                            style: .done,
                            target: self,
                            action: nil)
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"),
                            style: .plain,
                            target: self,
                            action: #selector(share))
        bodyNews.delegate = self
//        bodyNews.loadRequest(URLRequest(url: URL(string: "https://stackoverflow.com/questions/3341842/how-to-add-subview-to-a-webview-so-that-the-subview-would-scroll-along-with-webv")!))
        bodyNews.loadHTMLString("<p>ahihi&nbsp;ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi ahihi</p>", baseURL: nil)
        bodyNews.scrollView.isScrollEnabled = false
        
        detailNews.text = "down voteThe easiest way, IMO, is just to click on the title bar of the first ViewController and in the Attribute Inspector (⌥+⌘+4) change the Navigation Item info the way you want: Title -> what will show up in the back button* or if you want it to say something other than the Title of the first ViewController or the word Back you can just put it in the Back Button field."
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
        bottomView.pressBackButton = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        bottomView.pressedComment = {
            print("comment")
        }
        bottomView.pressedLike = {
            print("like")
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
