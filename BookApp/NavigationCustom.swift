//
//  NavigationCustom.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NavigationCustom: UIView {
    
    var callBackMessageNotification = {}
    var callBackVideoNotification = {}
    var callBackSearchNotification = {}

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
    
    @IBAction func pressedMessageNotification(_ sender: Any) {
        self.callBackMessageNotification()
    }
    
    @IBAction func pressedVideoNotification(_ sender: Any) {
        self.callBackVideoNotification()
    }

    @IBAction func pressedSearch(_ sender: Any) {
        self.callBackSearchNotification()
    }
}
