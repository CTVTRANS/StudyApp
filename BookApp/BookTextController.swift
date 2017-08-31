//
//  BookTextController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookTextController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var scroll: UIScrollView!
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let content = book?.content
        webview.loadHTMLString(content!, baseURL: nil)
        webview.delegate = self
        webview.scrollView.isScrollEnabled = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightNewOfWebView = webview.scrollView.contentSize.height
        hightOfWebView.constant = hightNewOfWebView
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
