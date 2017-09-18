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
    var bookSelected: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let checkLiked: CheckLikedTask = CheckLikedTask(likeType: Object.book.rawValue,
                                                        memberID: 1,
                                                        objectID: bookSelected.idBook)
        requestWithTask(task: checkLiked, success: { [weak self] (data) in
            let status = data as? Bool
            if status! {
                self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_liked")
            } else {
                self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_like")
            }
        }) { (_) in
            
        }
        let checkBookMarked: CheckBookMarkedTask = CheckBookMarkedTask(bookMarkType: Object.book.rawValue,
                                                                       memberID: 1,
                                                                       objectID: bookSelected.idBook)
        requestWithTask(task: checkBookMarked, success: { [weak self] (data) in
            let status = data as? Bool
            if status! {
                self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMarked")
            } else {
                self?.bottomView.bookMarkImage.image = #imageLiteral(resourceName: "ic_bottom_bookMark")
            }
        }) { (_) in
            
        }

        setupScroll()
        setupCallBackBottom()
        setupCallBackTopTabbar()
        setupSahreView()
        scroll.delegate = self
        
        bottomView.numberComment.text = String(bookSelected.numberComment)
        bottomView.numberLike.text = String(bookSelected.numberLike)
        bottomView.numberBookmark.text = String(bookSelected.numberBookMark)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupScroll() {
        scroll.contentSize = CGSize(width: 3 * widthScreen, height: scroll.frame.height)
        let audioVC =
            self.storyboard?.instantiateViewController(withIdentifier: "BookAudio") as? BookAudioController
        audioVC?.book = bookSelected
        audioVC?.view.frame = CGRect(x: 0,
                                    y: 0,
                                    width: scroll.frame.size.width,
                                    height: scroll.frame.height)
        let videoVC =
            self.storyboard?.instantiateViewController(withIdentifier: "BookVideo") as? BookVideoController
        videoVC?.book = bookSelected
        videoVC?.view.frame = CGRect(x: widthScreen,
                                    y: 0,
                                    width: scroll.frame.size.width,
                                    height: scroll.frame.height)
        let textVC =
            self.storyboard?.instantiateViewController(withIdentifier: "BookText") as? BookTextController
        textVC?.book = bookSelected
        textVC?.view.frame = CGRect(x: 2 * widthScreen,
                                   y: 0,
                                   width: scroll.frame.size.width,
                                   height: scroll.frame.height)
        audioVC?.willMove(toParentViewController: self)
        self.addChildViewController(audioVC!)
        audioVC?.didMove(toParentViewController: self)
        scroll.addSubview((audioVC?.view)!)
        
        videoVC?.willMove(toParentViewController: self)
        self.addChildViewController(videoVC!)
        videoVC?.didMove(toParentViewController: self)
        scroll.addSubview(videoVC!.view)
        
        textVC?.willMove(toParentViewController: self)
        self.addChildViewController(textVC!)
        textVC?.didMove(toParentViewController: self)
        scroll.addSubview(textVC!.view)
    }
    
    func setupSahreView() {
        topShare.titleTop.text = bookSelected?.name
    }

    func setupCallBackBottom() {
        bottomView.pressedBottomButton = { [weak self] (typeButton: BottomButton) in
            let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
            switch typeButton {
            case BottomButton.back:
                self?.navigationController?.popViewController(animated: true)
            case BottomButton.bookMark:
                let vc = myStoryboard.instantiateViewController(withIdentifier: "Login") as? UINavigationController
                self?.present(vc!, animated: true, completion: nil)
            case BottomButton.comment:
                let vc = myStoryboard.instantiateViewController(withIdentifier: "CommentController") as? CommentController
                vc?.idObject = self?.bookSelected?.idBook
                vc?.commentType = Object.book.rawValue
                self?.present(vc!, animated: false, completion: nil)
            case BottomButton.like:
                let likeTask: LikeTask = LikeTask(likeType: Object.book.rawValue,
                                                  memberID: 1,
                                                  objectId: self!.bookSelected.idBook)
                self?.requestWithTask(task: likeTask, success: { (data) in
                    let status: Like = (data as? Like)!
                    var currentLike: Int = Int(self!.bottomView.numberLike.text!)!
                    if status == Like.like {
                        self?.bottomView.likeImage.image = #imageLiteral(resourceName: "ic_bottom_liked")
                        currentLike += 1
                        self?.bookSelected.numberLike = currentLike
                        self?.bottomView.numberLike.text = String(currentLike)
                    } else {
                        currentLike -= 1
                        self?.bookSelected.numberLike = currentLike
                        self?.bottomView.numberLike.text = String(currentLike)
                    }
                }, failure: { (_) in
                    
                })
            case BottomButton.download:
                print("Download")
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position: CGFloat = scroll.contentOffset.x / scroll.frame.size.width
        if position > 1.7 {
            self.bottomView.downloadButton.isHidden = true
            self.bottomView.downloadImage.isHidden = true
        } else {
            self.bottomView.downloadButton.isHidden = false
            self.bottomView.downloadImage.isHidden = false
        }
        switch position {
        case 0...0.3 :
            topTabbar.audioButton.setTitleColor(UIColor.rgb(red: 255, green: 101, blue: 0), for: .normal)
            topTabbar.textButton.setTitleColor(UIColor.black, for: .normal)
            topTabbar.videoButton.setTitleColor(UIColor.black, for: .normal)
        case 0.8...1.2 :
            topTabbar.videoButton.setTitleColor(UIColor.rgb(red: 255, green: 101, blue: 0), for: .normal)
            topTabbar.textButton.setTitleColor(UIColor.black, for: .normal)
            topTabbar.audioButton.setTitleColor(UIColor.black, for: .normal)
        case 1.8...2.7 :
            topTabbar.textButton.setTitleColor(UIColor.rgb(red: 255, green: 101, blue: 0), for: .normal)
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
