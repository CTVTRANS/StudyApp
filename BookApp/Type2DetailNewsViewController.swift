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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "ok",
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
    
    private func setupCallBackButton() {
        bottomView.downloadButton.isHidden = true
        bottomView.downloadImage.isHidden = true
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

    @objc private func share() {
        print("share")
    }

}
