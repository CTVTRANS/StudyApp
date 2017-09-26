//
//  LKPlayer.swift
//  BookApp
//
//  Created by kien le van on 9/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LKPlayer: NSObject {
    
    private var _player: AVPlayer?
    private var _playerItem: AVPlayerItem?
    
    init(player: AVPlayer, playerItem: AVPlayerItem) {
        self._player = player
        self._playerItem = playerItem
    }
    
    var player: AVPlayer {
        get { return _player!}
        set { _player = newValue}
    }
    var playerItem: AVPlayerItem {
        get { return _playerItem!}
        set { _playerItem = newValue}
    }
    
    func play() {
        _player?.play()
    }
    func pause() {
        _player?.pause()
    }
}
