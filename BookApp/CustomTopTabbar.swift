//
//  CustomTopTabbar.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class CustomTopTabbar: UIView {
    
    var showAudioPressed = {}
    var showVideoPressed = {}
    var showTextPressed = {}

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

    @IBAction func showAudio(_ sender: Any) {
        showAudioPressed()
    }
    
    @IBAction func showVideo(_ sender: Any) {
        showVideoPressed()
    }
    
    @IBAction func showText(_ sender: Any) {
        showTextPressed()
    }
    
    
}
