//
//  DetailViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var bottomView: BottomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBackButton()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ok", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"), style: .plain, target: self, action: #selector(share))
    }
    
    private func setupCallBackButton() {
        bottomView.pressBackButton = {
            self.navigationController?.popViewController(animated: true)
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
    
    @objc private func share() {
        print("share")
    }

}
