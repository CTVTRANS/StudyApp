//
//  BookAudioController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVFoundation

class BookAudioController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var hightOfWebView: NSLayoutConstraint!
    
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var currentTimeAudio: UILabel!
    @IBOutlet weak var totalTimeAudio: UILabel!
    @IBOutlet weak var buttonImge: UIImageView!
    
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSliderBar()
        web.delegate = self
        web.loadRequest(URLRequest(url: URL(string: "https://stackoverflow.com/questions/3341842/how-to-add-subview-to-a-webview-so-that-the-subview-would-scroll-along-with-webv")!))
        web.scrollView.isScrollEnabled = false
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSessionCategoryPlayAndRecord,
                with: .defaultToSpeaker)
        } catch {
            print("Failed to set audio session category.  Error: \(error)")
        }
        
        player?.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 100), queue: DispatchQueue.main) {
            [weak self] time in
            guard let strongSelf = self else { return }
            let timeString = String(format: "%02.2f", CMTimeGetSeconds(time))
            
            if UIApplication.shared.applicationState == .active {
                strongSelf.currentTimeAudio.text = timeString
            } else {
                print("Background: \(timeString)")
            }
        }
        setPlayer()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        scroll.contentSize.height = hightOfContenWebView + headerView.frame.size.height + footerView.frame.size.height
    }
    
   
    
    func customSliderBar() {
        sliderBar.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        sliderBar.minimumTrackTintColor = UIColor.rgb(r: 255, g: 106, b: 6)
    }
    
    func setPlayer(){
        let url = URL(string: "http://data16.chiasenhac.com/downloads/1006/3/1005369-6e32c7ba/320/Mien%20Cat%20Trang%20-%20Quang%20Vinh%20[320kbps_MP3].mp3")
        let playerItem = AVPlayerItem(url: url!)
        let duration = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        let mySecs = Int(seconds) % 60
        let myMins = Int(seconds / 60)
        totalTimeAudio.text = String(myMins) + ":" + String(mySecs)

        player?.actionAtItemEnd = .advance
        player?.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player!)
        playerLayer?.frame=CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer!)
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        if player?.rate == 0 {
            player?.play()
            buttonImge.image = #imageLiteral(resourceName: "audio_pause")
        } else {
            player?.pause()
            buttonImge.image = #imageLiteral(resourceName: "audio_play")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
