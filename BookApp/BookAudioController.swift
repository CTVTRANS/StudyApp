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
    @IBOutlet weak var audioDetailButton: UIButton!
    
    private var loadedAudio: Bool = false
    private var loadedWebView: Bool = false
    var book: Book?
    private var totalTime: Float64?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        audioDetailButton.layer.borderColor = UIColor.rgb(red: 255, green: 101, blue: 0).cgColor
        imageBook.sd_setImage(with: URL(string: (book?.imageURL)!), placeholderImage: #imageLiteral(resourceName: "place_holder"))
        web.delegate = self
        let content = css + (book?.descriptionBook)!
        web.loadHTMLString(content, baseURL: nil)
        web.scrollView.isScrollEnabled = false
        sliderBar.minimumValue = 0
        loadAudio()
        NotificationCenter.default.addObserver(self, selector: #selector(stopAudio(notification:)), name: NSNotification.Name(rawValue: "videoDidStart"), object: nil)
    }
    
    func loadAudio() {
        Constants.sharedInstance.asset = AVAsset(url: URL(string: (self.book?.audio)!)!)
        let keys: [String] = ["audio"]
        Constants.sharedInstance.asset?.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                Constants.sharedInstance.playerItem = AVPlayerItem(asset: Constants.sharedInstance.asset!)
                Constants.sharedInstance.player = AVPlayer(playerItem: Constants.sharedInstance.playerItem)
                self.playerOvserver()
                let duration = Constants.sharedInstance.asset?.duration
                self.totalTime = CMTimeGetSeconds(duration!)
                self.customSliderBar()
                self.loadedAudio = true
                if self.loadedAudio && self.loadedWebView {
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    func playerOvserver() {
        Constants.sharedInstance.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: DispatchQueue.main) { [weak self] time in
            guard let strongSelf = self else {
                return
            }
            let timeString = String(format: "%02.0f", CMTimeGetSeconds(time))
            self?.sliderBar.value = Float(timeString)!
            if strongSelf.sliderBar.value >= strongSelf.sliderBar.maximumValue {
                Constants.sharedInstance.player?.seek(to: kCMTimeZero)
                Constants.sharedInstance.player?.pause()
                strongSelf.buttonImge.image = #imageLiteral(resourceName: "audio_play")
                strongSelf.sliderBar.value = strongSelf.sliderBar.minimumValue
                strongSelf.currentSecondTime.text = "00"
                strongSelf.currentMinAudio.text = "00:"
                return
            }
            if UIApplication.shared.applicationState == .active {
               self?.setDataForCurrentTime(timeString: timeString)
            }
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        imageBook.layer.cornerRadius = imageBook.frame.size.width / 2
        let hightOfContenWebView: CGFloat = web.scrollView.contentSize.height
        hightOfWebView.constant = hightOfContenWebView
        self.loadedWebView = true
        if self.loadedAudio && self.loadedWebView {
            self.stopActivityIndicator()
        }
    }
    
    func setDataForCurrentTime(timeString: String) {
        let second: Int = Int(timeString)!
        if second % 60 < 10 {
            currentSecondTime.text = "0" + String( second % 60)
        } else {
            currentSecondTime.text = String( second % 60)
        }
        
        if ( second / 60) > 0 {
            currentMinAudio.text = "0" + String (second / 60) + ":"
        } else if second / 60 > 9 {
            currentMinAudio.text = String (second / 60) + ":"
        }
    }
    
    func customSliderBar() {
        if Constants.sharedInstance.memberProfile != nil &&
            (Constants.sharedInstance.memberProfile?.level)! >= 0 {
            sliderBar.maximumValue = Float(totalTime!)
        } else {
             sliderBar.maximumValue = Float(90)
        }
        let mySecs = Int(totalTime!) % 60
        let myMins = Int(totalTime! / 60)
        self.totalTimeAudio.text = String(myMins) + ":" + String(mySecs)
        sliderBar.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        sliderBar.minimumTrackTintColor = UIColor.rgb(red: 255, green: 106, blue: 6)
        sliderBar.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
    }
    
    func playbackSliderValueChanged(_ playbackSlider: UISlider) {
        let seconds: Int64 = Int64(playbackSlider.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)
         Constants.sharedInstance.player?.seek(to: targetTime)
    }
    
    func videoDidStart(note: NSNotification) {
        if  Constants.sharedInstance.player?.rate == 0 {
            print("pause video")
        } else {
            print("start video")
        }
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        if Constants.sharedInstance.player?.rate == 0 {
            Constants.sharedInstance.player?.play()
            Constants.sharedInstance.historyViewAudio.append(book!)
            buttonImge.image = #imageLiteral(resourceName: "audio_pause")
        } else {
            Constants.sharedInstance.player?.pause()
            buttonImge.image = #imageLiteral(resourceName: "audio_play")
        }
    }
    
    @IBAction func pressedPrevious(_ sender: Any) {
        sliderBar.value -= 15
        let seconds: Int64 = Int64(sliderBar.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)
        Constants.sharedInstance.player?.seek(to: targetTime)
    }
    
    @IBAction func pressedNext(_ sender: Any) {
        sliderBar.value += 15
        let seconds: Int64 = Int64(sliderBar.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)
         Constants.sharedInstance.player?.seek(to: targetTime)
    }
    
    func stopAudio(notification: Notification) {
        if Constants.sharedInstance.player?.rate == 1 {
            Constants.sharedInstance.player?.pause()
            buttonImge.image = #imageLiteral(resourceName: "audio_play")
        }
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
