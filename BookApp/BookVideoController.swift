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
        videoDetailButton.layer.borderColor = UIColor.rgb(red: 255, green: 101, blue: 0).cgColor
        web.delegate = self
        let content = css + (book?.description)!
        web.loadHTMLString(content, baseURL: nil)
        web.scrollView.isScrollEnabled = false
        loadVideo()
    }
    
    func loadVideo() {
        let asset = AVAsset(url: URL(string: (self.book?.video)!)!)
        let keys: [String] = ["video"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                let item = AVPlayerItem(asset: asset)
                self.player = AVPlayer(playerItem: item)
                self.player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
                
                self.playerViewController.player =  self.player
                self.playerViewController.view.frame = self.headerView.bounds
                self.headerView.addSubview(self.playerViewController.view)
                self.loadedVideo = true
                if self.loadedVideo && self.loadedWebView {
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if  keyPath == "rate" {
            let layer = object as? AVPlayer
            if layer?.rate == 1.0 {
                let notificationName = Notification.Name("videoDidStart")
                NotificationCenter.default.post(name: notificationName, object: nil)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }

    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let currentviewController =  navigationController?.visibleViewController
        
        if currentviewController != playerViewController {
            currentviewController?.present(playerViewController, animated: true, completion: nil)
        }

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        print(web.frame.size.height)
        self.loadedWebView = true
        if self.loadedVideo && self.loadedWebView {
            self.stopActivityIndicator()
        }
    }
    
    @IBAction func pressedStart(_ sender: Any) {
        
    }
    
    deinit {
        player?.removeObserver(self, forKeyPath: "rate")
        NotificationCenter.default.removeObserver(self)
    }
}
