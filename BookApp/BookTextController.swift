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
    
    @IBOutlet weak var textDetailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        textDetailButton.layer.borderColor = UIColor.rgb(red: 255, green: 101, blue: 0).cgColor
        let content: String = css + (book?.content)!
        webview.loadHTMLString(content, baseURL: nil)
        webview.delegate = self
        webview.scrollView.isScrollEnabled = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightNewOfWebView = webview.scrollView.contentSize.height
        hightOfWebView.constant = hightNewOfWebView
        stopActivityIndicator()
    }
    
    @IBAction func pressedBuy(_ sender: Any) {
        let myStoryBoard = UIStoryboard(name: "Setting", bundle: nil)
        if let vc = myStoryBoard.instantiateViewController(withIdentifier: "BuyProductViewController") as? BuyProductViewController {
            vc.product = book
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
