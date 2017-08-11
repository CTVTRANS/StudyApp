//
//  BottomView.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BottomView: UIView {
    
    var pressBackButton = {}
    var pressedComment = {}
    var pressedLike = {}
    var pressedBookMark = {}
    var pressedDownload = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        let view = viewfromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleHeight,
            UIViewAutoresizing.flexibleWidth
        ]
        addSubview(view)
    }
    
    private func viewfromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    @IBAction func pressedBack(_ sender: Any) {
        self.pressBackButton()
    }
    
    @IBAction func pressedComment(_ sender: Any) {
        self.pressedComment()
    }
    
    @IBAction func pressedLikeButton(_ sender: Any) {
        self.pressedLike()
    }

    @IBAction func pressedBookMarkButton(_ sender: Any) {
        self.pressedBookMark()
    }
    
    @IBAction func pressedDownloadButton(_ sender: Any) {
        self.pressedDownload()
    }
}
