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
    
    var _originY: CGFloat?
    var _hightOfAnimationView: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        setupCallBackBottom()
        setupCallBackTopTabbar()
        scroll.delegate = self
    }
    
    func setupScroll() {
        scroll.contentSize = CGSize(width: 3 * widthScreen, height: scroll.frame.height)
        let audioVC: BookAudioController = self.storyboard?.instantiateViewController(withIdentifier: "BookAudio") as! BookAudioController
        audioVC.view.frame = CGRect(x: 0, y: 0, width: scroll.frame.size.width, height: scroll.frame.height)
        let videoVC: BookVideoController = self.storyboard?.instantiateViewController(withIdentifier: "BookVideo") as! BookVideoController
        videoVC.view.frame = CGRect(x: widthScreen, y: 0, width: scroll.frame.size.width, height: scroll.frame.height)
        let textVC: BookTextController = self.storyboard?.instantiateViewController(withIdentifier: "BookText") as! BookTextController
        textVC.view.frame = CGRect(x: 2 * widthScreen, y: 0, width: scroll.frame.size.width, height: scroll.frame.height)
        
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
        if (Int(position) == 2) {
            self.bottomView.downloadButton.isHidden = true
            self.bottomView.downloadImage.isHidden = true
            return
        } else {
            self.bottomView.downloadButton.isHidden = false
            self.bottomView.downloadImage.isHidden = false
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
            self?._originY = originY
            self?._hightOfAnimationView = hightView
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
