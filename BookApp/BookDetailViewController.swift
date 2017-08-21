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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        setupCallBackBottom()
        setupCallBackTopTabbar()
        
    }
    
    func setupScroll() {
        scroll.isPagingEnabled = true
        scroll.contentSize = CGSize(width: 3 * view.frame.width, height: scroll.frame.height)
        let audioVC: BookAudioController = self.storyboard?.instantiateViewController(withIdentifier: "BookAudio") as! BookAudioController
        audioVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scroll.frame.height)
        let videoVC: BookVideoController = self.storyboard?.instantiateViewController(withIdentifier: "BookVideo") as! BookVideoController
        videoVC.view.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: scroll.frame.height)
        let textVC: BookTextController = self.storyboard?.instantiateViewController(withIdentifier: "BookText") as! BookTextController
        textVC.view.frame = CGRect(x: 2 * view.frame.width, y: 0, width: view.frame.width, height: scroll.frame.height)
        
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
    }
    
    func setupCallBackTopTabbar() {
        topTabbar.showAudioPressed = { [weak self] in
            self?.scroll.contentOffset = CGPoint(x: 0, y: 0)
        }
        
        topTabbar.showVideoPressed = { [weak self] in
            self?.scroll.contentOffset = CGPoint(x: widthScreen, y: 0)
        }
        
        topTabbar.showTextPressed = { [weak self] in
            self?.scroll.contentOffset = CGPoint(x: 2 * widthScreen, y: 0)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
