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
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    var y: CGFloat?
    var width: CGFloat?
    var hight: CGFloat?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        y = animationView.frame.origin.y
        width = widthScreen/3
        hight = animationView.frame.size.height
    
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
        let newFrame = CGRect(x: audioButton.frame.origin.x, y: y!, width: width!, height: hight!)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.animationView.frame = newFrame
            }, completion: nil
        )
    }
    
    @IBAction func showVideo(_ sender: Any) {
         showVideoPressed()
        let newFrame = CGRect(x: videoButton.frame.origin.x, y: y!, width: width!, height: hight!)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.animationView.frame = newFrame
            }, completion: nil
        )
    }
    
    @IBAction func showText(_ sender: Any) {
        showTextPressed()
        let newFrame = CGRect(x: textButton.frame.origin.x, y: y!, width: width!, height: hight!)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            self.animationView.frame = newFrame
            }, completion: nil
        )
    }
    
    
}
