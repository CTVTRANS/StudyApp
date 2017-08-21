//
//  BookVideoController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookVideoController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.delegate = self
        web.loadRequest(URLRequest(url: URL(string: "https://stackoverflow.com/questions/3341842/how-to-add-subview-to-a-webview-so-that-the-subview-would-scroll-along-with-webv")!))
        web.scrollView.isScrollEnabled = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        scroll.contentSize.height = hightOfContenWebView + headerView.frame.size.height + footerView.frame.size.height
        print(web.frame.size.height)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
