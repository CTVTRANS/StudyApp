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
    @IBOutlet weak var audioDetailButton: UIButton!
    
    private lazy var mp3 = MP3Player.shareIntanse
    private var loadedAudio: Bool = true
    private var loadedWebView: Bool = false
    var book: Book?
    private var totalTime: Float64? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: UIApplication.shared.keyWindow!)
        customSliderBar()
        loadWebView()
        checkAudio()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopAudio(notification:)),
                                               name: NSNotification.Name(rawValue: "videoDidStart"),
                                               object: nil)
    }
    
    func loadWebView() {
        audioDetailButton.layer.borderColor = UIColor.rgb(255, 101, 0).cgColor
        imageBook.sd_setImage(with: URL(string: (book?.imageURL)!), placeholderImage: #imageLiteral(resourceName: "place_holder"))
        web.delegate = self
        let content = css + (book?.descriptionBook)!
        web.loadHTMLString(content, baseURL: nil)
        web.scrollView.isScrollEnabled = false
    }
    
    func checkAudio() {
        if let currentBook = mp3.currentAudio as? Book {
            sliderBar.value = mp3.getCurrentTime().0
            currentMinAudio.text = mp3.getCurrentTime().1
            totalTimeAudio.text = mp3.getTotalTimeString()
            if currentBook.idBook == book?.idBook && mp3.isPlaying() {
                buttonImge.image = #imageLiteral(resourceName: "audio_pause")
                playerOvserver()
            } else if currentBook.idBook == book?.idBook && !mp3.isPlaying() {
                buttonImge.image = #imageLiteral(resourceName: "audio_play")
                playerOvserver()
            } else {
                sliderBar.value = 0.0
                currentMinAudio.text = "00:00"
                totalTimeAudio.text = mp3.getTotalTimeString()
            }
            return
        }
        mp3.currentAudio = nil
        mp3.player?.pause()
        mp3.player = nil
    }
    
    func loadAudio() {
        mp3.track(object: book!, types: TypePlay.onLine)
        mp3.didLoadAudio = { [weak self] timeFloat, timeString in
            if Constants.sharedInstance.memberProfile != nil &&
                (Constants.sharedInstance.memberProfile?.level)! >= 0 {
                self?.sliderBar.maximumValue = timeFloat
            } else {
                self?.sliderBar.maximumValue = Float(90)
            }
            self?.totalTimeAudio.text = timeString
            self?.playerOvserver()
        }
    }
    
    func playerOvserver() {
        mp3.player?.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 1), queue: DispatchQueue.main, using: { [weak self] time in
            guard let strongSelf = self else {
                return
            }
            let time = self?.mp3.getCurrentTime()
            strongSelf.sliderBar.value = (time?.0)!
            if (time?.0)! > strongSelf.sliderBar.maximumValue {
                self?.mp3.player?.seek(to: kCMTimeZero)
                self?.mp3.player?.pause()
                strongSelf.buttonImge.image = #imageLiteral(resourceName: "audio_play")
                strongSelf.sliderBar.value = strongSelf.sliderBar.minimumValue
                 strongSelf.currentMinAudio.text = "00:00"
                return
            }
            if UIApplication.shared.applicationState == .active {
                strongSelf.currentMinAudio.text = time?.1
            }
        })
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
    
    func customSliderBar() {
        sliderBar.minimumValue = 0.0
        sliderBar.value = 0.0
        sliderBar.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        sliderBar.minimumTrackTintColor = UIColor.rgb(255, 106, 6)
        sliderBar.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
    }
    
    func playbackSliderValueChanged(_ playbackSlider: UISlider) {
        let seconds: Int64 = Int64(playbackSlider.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)
        mp3.player?.seek(to: targetTime)
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        loadAudio()
        if buttonImge.image == #imageLiteral(resourceName: "audio_play") {
            mp3.play()
            buttonImge.image = #imageLiteral(resourceName: "audio_pause")
        } else {
            mp3.pause()
            buttonImge.image = #imageLiteral(resourceName: "audio_play")
        }
    }
    
    @IBAction func pressedPrevious(_ sender: Any) {
        sliderBar.value -= 15
        let seconds: Int64 = Int64(sliderBar.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)
        mp3.player?.seek(to: targetTime)
    }
    
    @IBAction func pressedNext(_ sender: Any) {
        sliderBar.value += 15
        let seconds: Int64 = Int64(sliderBar.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)
        mp3.player?.seek(to: targetTime)
    }
    
    func stopAudio(notification: Notification) {
        if mp3.isPlaying() {
            mp3.pause()
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
