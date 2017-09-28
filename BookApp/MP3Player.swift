//
//  MP3Player.swift
//  BookApp
//
//  Created by kien le van on 9/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVFoundation

class MP3Player: NSObject {
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var currentBook: Book?
    private var currentLesson: Lesson?
    static let sharedInstance = Constants()

    static func shareIntanse() -> MP3Player {
        let mp3 = MP3Player()
        return mp3
    }
    
    func track(object: AnyObject) {
        if let book = object as? Book {
            playBook(book: book)

        }
        if let lesson = object as? Lesson {
            playLesson(lesson: lesson)
        }
    }
    
    func playBook(book: Book) {
        if currentBook?.idBook != book.idBook {
            playerItem = AVPlayerItem(url: URL(string:book.audio)!)
            player = AVPlayer(playerItem: playerItem)
            play()
            currentBook = book
        }
    }
    
    func playLesson(lesson: Lesson) {
        if currentLesson?.idChap != lesson.idChap {
            playerItem = AVPlayerItem(url: URL(string:lesson.contentURL)!)
            player = AVPlayer(playerItem: playerItem)
            play()
            currentLesson = lesson
        }
    }
    
    func isPlaying() -> Bool {
        if player?.rate == 1 {
            return true
        } else {
            return false
        }
    }
    
    func play() {
        if player?.rate == 0 {
            player?.play()
        }
    }
    
    func pause() {
        if player?.rate == 1 {
            player?.pause()
        }
    }
    
    func getTotalTime() -> (Float, String) {
        let duration = playerItem?.asset.duration
        let totalTime = CMTimeGetSeconds(duration!)
        let sec = Int(totalTime) % 60
        let min = Int(totalTime) / 60
        let timeString = String(format: "%0.2d:%0.2d", min, sec)
        let timeFloat = Float(totalTime)
        return (timeFloat, timeString)
    }
}
