//
//  Type2DetailNewsViewController.swift
//  BookApp
//
//  Created by kien le van on 8/23/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class Type2DetailNewsViewController: BaseViewController {

    @IBOutlet weak var viewBounds: UIView!
    @IBOutlet weak var bottomView: BottomView!
    
    @IBOutlet weak var timeUp: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    var news: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: news?.title,
                            style: .done,
                            target: self,
                            action: nil)
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"),
                            style: .plain,
                            target: self,
                            action: #selector(share))
        viewBounds.layer.borderColor = UIColor.rgb(r: 52, g: 52, b: 52).cgColor
        setupCallBackButton()
    }
    
    func setupUI() {
        userName.text = news.author
        timeUp.text = news.timeUp
        content.text = news.content
    }
    
    private func setupCallBackButton() {
        bottomView.downloadButton.isHidden = true
        bottomView.downloadImage.isHidden = true
        bottomView.numberLike.text = String(news.numberLike)
        bottomView.numberComment.text = String(news.numberComment)
        
        bottomView.pressBackButton = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        bottomView.pressedComment = { [weak self] in
            let storyboard = UIStoryboard(name: "Global", bundle: nil)
            let vc: CommentController = storyboard.instantiateViewController(withIdentifier: "CommentController") as! CommentController
            vc.idObject = self?.news.id
            vc.commentType = 0
            self?.present(vc, animated: true, completion: nil)
        }
        bottomView.pressedLike = { [weak self] in
            let likeTask: LikeTask = LikeTask(likeType: 0, memberID: 1, objectId: self!.news.id)
            self?.requestWithTask(task: likeTask, success: { (data) in
                let status: Like = (data as? Like)!
                var currentLike: Int = Int(self!.bottomView.numberLike.text!)!
                if status == Like.LIKE {
                    currentLike += 1
                    self?.news.numberLike = currentLike
                    self?.bottomView.numberLike.text = String(currentLike)
                } else {
                    currentLike -= 1
                    self?.news.numberLike = currentLike
                    self?.bottomView.numberLike.text = String(currentLike)
                }
            }, failure: { (error) in
                
            })
        }
        bottomView.pressedBookMark = {
            print("bookmark")
        }
        bottomView.pressedDownload = {
            print("download")
        }
    }

    @objc private func share() {
        print("share")
    }

}
