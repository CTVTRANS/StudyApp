//
//  VideoPlayerView.swift
//  BookApp
//
//  Created by kien le van on 10/2/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {

    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = false
    
    func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(#imageLiteral(resourceName: "audio_play"), for: UIControlState())
        } else {
            player?.play()
            pausePlayButton.setImage(#imageLiteral(resourceName: "audio_pause"), for: UIControlState())
        }
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        if #available(iOS 9.0, *) {
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            controlsContainerView.addSubview(pausePlayButton)
            pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        } else {
            // Fallback on earlier versions
        }
        backgroundColor = .black
    }
    
    var player: AVPlayer?
    
    fileprivate func setupPlayerView() {
        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
