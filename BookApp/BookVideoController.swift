//
//  BookVideoController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class BookVideoController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    
    var book: Book?
    let playerViewController = AVPlayerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivity(withName: "loading...")
        web.delegate = self
        let content = book?.content
        web.loadHTMLString(content!, baseURL: nil)
        web.scrollView.isScrollEnabled = false
        let video = book?.video
        let videoURL = URL(string: video!)
        let player = AVPlayer(url: videoURL!)
        let duration = player.currentItem?.asset.duration
        let totalTime: Float64 = CMTimeGetSeconds(duration!)
        let mySecs = Int(totalTime) % 60
        let myMins = Int(totalTime / 60)
        print("\(myMins): \(mySecs)")

        playerViewController.player = player
        playerViewController.view.frame = headerView.bounds
        headerView.addSubview(playerViewController.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        scroll.contentSize.height = hightOfContenWebView + headerView.frame.size.height + footerView.frame.size.height
        print(web.frame.size.height)
        self.stopActivityIndicator()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
