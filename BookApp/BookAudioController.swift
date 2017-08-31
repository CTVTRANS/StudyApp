//
//  BookAudioController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class BookAudioController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var currentMinAudio: UILabel!
    @IBOutlet weak var totalTimeAudio: UILabel!
    @IBOutlet weak var buttonImge: UIImageView!
    @IBOutlet weak var currentSecondTime: UILabel!
    
    var loadedAudio: Bool = false
    var loadedWebView: Bool = false
    var book: Book?
    var totalTime: Float64?
//    lazy var player: AVQueuePlayer = self.makePlayer()
    var player: AVQueuePlayer!
    var playerItem: AVPlayerItem?
    
//    private lazy var song: AVPlayerItem = {
//        let url = URL(string: (self.book?.audio)!)
//        self.playerItem = AVPlayerItem(url: url!)
//        let duration = self.playerItem?.asset.duration
//        self.totalTime = CMTimeGetSeconds(duration!)
//        return self.playerItem!
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        imageBook.sd_setImage(with: URL(string: (book?.imageURL)!))
        web.delegate = self
        let content = book?.description
        web.loadHTMLString(content!, baseURL: nil)
        web.scrollView.isScrollEnabled = false
        sliderBar.minimumValue = 0
        loadAudio()
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSessionCategoryPlayAndRecord,
                with: .defaultToSpeaker)
        } catch {
            print("Failed to set audio session category.  Error: \(error)")
        }
    }
    
    func loadAudio() {
        let asset = AVAsset(url: URL(string: (self.book?.audio)!)!)
        let keys: [String] = ["audio"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                let item = AVPlayerItem(asset: asset)
                self.player = AVQueuePlayer(playerItem: item)
                self.player.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
                self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: DispatchQueue.main) {
                    [weak self] time in
                    guard let strongSelf = self else {
                        return
                    }
                    let timeString = String(format: "%02.0f", CMTimeGetSeconds(time))
                    self?.sliderBar.value += 1
                    
                    if UIApplication.shared.applicationState == .active {
                        let second: Int = Int(timeString)!
                        if ( second % 60 ) < 10 {
                            strongSelf.currentSecondTime.text = "0" + String( second % 60)
                        } else {
                            strongSelf.currentSecondTime.text = String( second % 60)
                        }
                        
                        if ( second / 60) > 0 {
                            strongSelf.currentMinAudio.text = "0" + String (second / 60) + ":"
                        } else if (second / 60 > 9) {
                            strongSelf.currentMinAudio.text = String (second / 60) + ":"
                        }
                    } else {
                        print("Background: \(timeString)")
                    }
                }
                let duration = asset.duration
                self.totalTime = CMTimeGetSeconds(duration)
                self.customSliderBar()
                self.loadedAudio = true
                if (self.loadedAudio && self.loadedWebView) {
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        imageBook.layer.cornerRadius = imageBook.frame.size.width / 2
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        self.loadedWebView = true
        if (self.loadedAudio && self.loadedWebView) {
            self.stopActivityIndicator()
        }
    }
   
//    private func makePlayer() -> AVQueuePlayer {
//        let player = AVQueuePlayer(playerItem: song)
//        player.actionAtItemEnd = .advance
//        player.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
//        return player
//    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem", let player = object as? AVPlayer,
            let _ = player.currentItem?.asset as? AVURLAsset {
        }
    }
    
    func customSliderBar() {
        sliderBar.maximumValue = Float(totalTime!)
        let mySecs = Int(totalTime!) % 60
        let myMins = Int(totalTime! / 60)
        self.totalTimeAudio.text = String(myMins) + ":" + String(mySecs)
        sliderBar.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        sliderBar.minimumTrackTintColor = UIColor.rgb(r: 255, g: 106, b: 6)
        sliderBar.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
    }
    
    func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        player.seek(to: targetTime)
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        if player.rate == 0 {
            player.play()
            buttonImge.image = #imageLiteral(resourceName: "audio_pause")
        } else {
            player.pause()
            buttonImge.image = #imageLiteral(resourceName: "audio_play")
        }
    }
    
    @IBAction func pressedPrevious(_ sender: Any) {
        sliderBar.value = sliderBar.value - 15
        let seconds : Int64 = Int64(sliderBar.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        player.seek(to: targetTime)
    }
    @IBAction func pressedNext(_ sender: Any) {
        sliderBar.value = sliderBar.value + 15
        let seconds : Int64 = Int64(sliderBar.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        player.seek(to: targetTime)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
