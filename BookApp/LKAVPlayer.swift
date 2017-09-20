//
//  LKAVPlayer.swift
//  BookApp
//
//  Created by kien le van on 9/1/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LKAVPlayer: NSObject {
    
    var audioPlayer: AVPlayer?
    static let sharedInstance = LKAVPlayer()
}
