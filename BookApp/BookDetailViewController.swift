//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookDetailViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var topShare: TopViewShare!
    @IBOutlet weak var topTabbar: CustomTopTabbar!
    @IBOutlet weak var bottomView: BottomView!
    var bookSelected: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        setupCallBackBottom()
        setupCallBackTopTabbar()
        setupSahreView()
        scroll.delegate = self
    }
    
    func setupScroll() {
        scroll.contentSize = CGSize(width: 3 * widthScreen, height: scroll.frame.height)
        let audioVC: BookAudioController =
            self.storyboard?.instantiateViewController(withIdentifier: "BookAudio") as! BookAudioController
        audioVC.book = bookSelected
        audioVC.view.frame = CGRect(x: 0,
                                    y: 0,
                                    width: scroll.frame.size.width,
                                    height: scroll.frame.height)
        let videoVC: BookVideoController =
            self.storyboard?.instantiateViewController(withIdentifier: "BookVideo") as! BookVideoController
        videoVC.book = bookSelected
        videoVC.view.frame = CGRect(x: widthScreen,
                                    y: 0,
                                    width: scroll.frame.size.width,
                                    height: scroll.frame.height)
        let textVC: BookTextController =
            self.storyboard?.instantiateViewController(withIdentifier: "BookText") as! BookTextController
        textVC.book = bookSelected
        textVC.view.frame = CGRect(x: 2 * widthScreen,
                                   y: 0,
                                   width: scroll.frame.size.width,
                                   height: scroll.frame.height)
        audioVC.willMove(toParentViewController: self)
        self.addChildViewController(audioVC)
        audioVC.didMove(toParentViewController: self)
        scroll.addSubview(audioVC.view)
        
        videoVC.willMove(toParentViewController: self)
        self.addChildViewController(videoVC)
        videoVC.didMove(toParentViewController: self)
        scroll.addSubview(videoVC.view)
        
        textVC.willMove(toParentViewController: self)
        self.addChildViewController(textVC)
        textVC.didMove(toParentViewController: self)
        scroll.addSubview(textVC.view)

    }
    
    func setupSahreView() {
        topShare.titleTop.text = bookSelected?.name
    }

    func setupCallBackBottom() {
        bottomView.pressBackButton = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        bottomView.pressedComment = {
            print("comment")
        }
        
        bottomView.pressedLike = {
            print("like")
        }
        
        bottomView.pressedBookMark = {
            print("bookmark")
        }
        
        bottomView.pressedDownload = {
            print("download")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position: CGFloat = scroll.contentOffset.x / scroll.frame.size.width
        if ( position > 1.7) {
            self.bottomView.downloadButton.isHidden = true
            self.bottomView.downloadImage.isHidden = true
        } else {
            self.bottomView.downloadButton.isHidden = false
            self.bottomView.downloadImage.isHidden = false
        }
        switch position {
        case 0...0.3 :
            topTabbar.audioButton.setTitleColor(UIColor.rgb(r: 255, g: 101, b: 0), for: .normal)
            topTabbar.textButton.setTitleColor(UIColor.black, for: .normal)
            topTabbar.videoButton.setTitleColor(UIColor.black, for: .normal)
        case 0.8...1.2 :
            topTabbar.videoButton.setTitleColor(UIColor.rgb(r: 255, g: 101, b: 0), for: .normal)
            topTabbar.textButton.setTitleColor(UIColor.black, for: .normal)
            topTabbar.audioButton.setTitleColor(UIColor.black, for: .normal)
        case 1.8...2.7 :
            topTabbar.textButton.setTitleColor(UIColor.rgb(r: 255, g: 101, b: 0), for: .normal)
            topTabbar.videoButton.setTitleColor(UIColor.black, for: .normal)
            topTabbar.audioButton.setTitleColor(UIColor.black, for: .normal)
        default: break
            
    }
        
        let newFrame = CGRect(x: position * (widthScreen / 3),
                              y: topTabbar.animationView.frame.origin.y,
                              width: widthScreen / 3,
                              height: topTabbar.animationView.frame.size.height)
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [], animations: {
            self.topTabbar.animationView.frame = newFrame
            }, completion: nil
        )
    }
    
    func setupCallBackTopTabbar() {
        topTabbar.changeViewPressed = {[weak self] (originX: CGFloat, originY: CGFloat, widthView: CGFloat, hightView: CGFloat, index: Int) in
            self?.scroll.contentOffset = CGPoint(x: CGFloat(index) * widthScreen, y: 0)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
