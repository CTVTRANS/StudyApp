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
    
    var loadedVideo: Bool = false
    var loadedWebView: Bool = false
    var book: Book?
    let playerViewController = AVPlayerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        web.delegate = self
        let content = book?.description
        web.loadHTMLString(content!, baseURL: nil)
        web.scrollView.isScrollEnabled = false
        loadVideo()
    }
    
    func loadVideo() {
        let asset = AVAsset(url: URL(string: (self.book?.video)!)!)
        let keys: [String] = ["video"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                let item = AVPlayerItem(asset: asset)
                let player = AVQueuePlayer(playerItem: item)
                self.playerViewController.player = player
                self.playerViewController.view.frame = self.headerView.bounds
                self.headerView.addSubview(self.playerViewController.view)
                self.loadedVideo = true
                if (self.loadedVideo && self.loadedWebView) {
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        print(web.frame.size.height)
        self.loadedWebView = true
        if (self.loadedVideo && self.loadedWebView) {
            self.stopActivityIndicator()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
