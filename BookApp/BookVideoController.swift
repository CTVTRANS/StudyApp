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
import MediaPlayer

class BookVideoController: BaseViewController, UIWebViewDelegate, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    
    @IBOutlet weak var videoDetailButton: UIButton!
    var loadedVideo: Bool = false
    var loadedWebView: Bool = false
    var book: Book?
    var player: AVPlayer?
    let playerViewController = AVPlayerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        videoDetailButton.layer.borderColor = UIColor.rgb(r: 255, g: 101, b: 0).cgColor
        web.delegate = self
        let content = css + (book?.description)!
        web.loadHTMLString(content, baseURL: nil)
        web.scrollView.isScrollEnabled = false
        loadVideo()
        if #available(iOS 9.0, *) {
            playerViewController.delegate = self
        } else {
            // Fallback on earlier versions
        }
    }
    
    func loadVideo() {
        let asset = AVAsset(url: URL(string: (self.book?.video)!)!)
        let keys: [String] = ["video"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                let item = AVPlayerItem(asset: asset)
                self.player = AVPlayer(playerItem: item)
                self.player?.addObserver(self, forKeyPath: "currentTime", options: NSKeyValueObservingOptions.new , context: nil)

                self.playerViewController.player =  self.player
                self.playerViewController.view.frame = self.headerView.bounds
                self.headerView.addSubview(self.playerViewController.view)
                self.loadedVideo = true
                if (self.loadedVideo && self.loadedWebView) {
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if  keyPath == "currentTime" {

        }
    }
    
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("start")
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
