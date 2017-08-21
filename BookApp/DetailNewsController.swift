//
//  DetailViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailNewsController: BaseViewController {

    @IBOutlet weak var bottomView: BottomView!
    @IBOutlet weak var bodyNews: UILabel!
    @IBOutlet weak var detailNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBackButton()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ok", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"), style: .plain, target: self, action: #selector(share))
        bodyNews.text = "down voteThe easiest way, IMO, is just to click on the title bar of the first ViewController and in the Attribute Inspector (⌥+⌘+4) change the Navigation Item info the way you want: Title -> what will show up in the back button* or if you want it to say something other than the Title of the first ViewController or the word Back you can just put it in the Back Button field.down voteThe easiest way, IMO, is just to click on the title bar of the first ViewController and in the Attribute Inspector (⌥+⌘+4) change the Navigation Item info the way you want: Title -> what will show up in the back button* or if you want it to say something other than the Title of the first ViewController or the word Back you can just put it in the Back Button field."
        detailNews.text = "down voteThe easiest way, IMO, is just to click on the title bar of the first ViewController and in the Attribute Inspector (⌥+⌘+4) change the Navigation Item info the way you want: Title -> what will show up in the back button* or if you want it to say something other than the Title of the first ViewController or the word Back you can just put it in the Back Button field."
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