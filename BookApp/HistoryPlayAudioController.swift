//
//  NotificationVideoViewController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HistoryPlayAudioController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    private var oldObjectPlay: Int?
    @IBOutlet weak var table: UITableView!
    
    private lazy var mp3 = MP3Player.shareIntanse
    private var listHistory: [AnyObject] = []
//    private var currenIndex: Int?
    private var downloadImageSuccess = false
    private var downloadAuidosucess = false
    var asset: AVAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        listHistory = mp3.listPlay as [AnyObject]
        mp3.oldIndexListPlay = mp3.getCurrentIndex()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "HistoryPlayAudioCell", for: indexPath) as? HistoryPlayAudioCell
        let row = listHistory.count - 1 - indexPath.row
        cell?.bindData(historyObject: listHistory[row])
        if mp3.oldIndexListPlay == row && mp3.isPlaying() {
            cell?.imagePlay.image = #imageLiteral(resourceName: "pauseList")
        } else {
            cell?.imagePlay.image = #imageLiteral(resourceName: "playList")
        }
        
        cell?.callBackDownload = { oject in
            if let book = oject as? Book {
                let download = DownloadViewController()
                download.downloadBook(book: book)
            }
            if let lesson = oject as? Lesson {
                let download = DownloadViewController()
                download.downloadLesson(lesson: lesson)
            }
        }
        
        cell?.callBackPlayAudio = { [weak self] object in
            self?.playAudio(object: object, current: row)
        }
        return cell!
    }
    
    func downloadAudio(book: Book) {
        let downloadImage = DownloadTask(path: book.imageURL)
        downloadFileSuccess(task: downloadImage, success: { (data) in
            if let imageOflline = data as? URL {
                self.downloadImageSuccess = true
                book.imageOffline = imageOflline
                if self.downloadAuidosucess && self.downloadImageSuccess {
                    self.saveAudio(book: book)
                }
            }
        }) { (_) in
        }
        let downloadAudio = DownloadTask(path: book.audio)
        downloadFileSuccess(task: downloadAudio, success: { (data) in
            if let audioOffline = data as? URL {
                self.downloadAuidosucess = true
                book.audioOffline = audioOffline
                if self.downloadAuidosucess && self.downloadImageSuccess {
                    self.saveAudio(book: book)
                }
            }
        }) { (_) in
        }
    }
    
    func playBook(book: Book, index: Int) {
        if let current = mp3.currentAudio as? Book {
            if book.idBook == current.idBook && mp3.isPlaying() {
                mp3.pause()
                mp3.oldIndexListPlay = nil
                table.reloadData()
                return
            } else if book.idBook == current.idBook && !mp3.isPlaying() {
                mp3.play()
                mp3.oldIndexListPlay = index
                table.reloadData()
                return
            }
        }
        mp3.oldIndexListPlay = index
        mp3.track(object: book)
        table.reloadData()
    }
    
    func playLesson(lesson: Lesson, index: Int) {
        if let current = mp3.currentAudio as? Lesson {
            if lesson.idChap == current.idChap && mp3.isPlaying() {
                mp3.pause()
                mp3.oldIndexListPlay = nil
                table.reloadData()
                return
            } else if lesson.idChap == current.idChap && !mp3.isPlaying() {
                mp3.play()
                mp3.oldIndexListPlay = index
                table.reloadData()
                return
            }
        }
        mp3.oldIndexListPlay = index
        mp3.track(object: lesson)
        table.reloadData()
    }
    
    func playAudio(object: AnyObject, current: Int) {
        if let book = object as? Book {
            playBook(book: book, index: current)
        }
        
        if let lesson = object as? Lesson {
            playLesson(lesson: lesson, index: current)
        }
    }

    func saveAudio(book: Book) {
        var listBookDownaloaed = Book.getBook()
        for singleBook in listBookDownaloaed! where singleBook.idBook == book.idBook {
            return
        }
        listBookDownaloaed?.append(book)
        Book.saveBook(myBook: listBookDownaloaed!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func pressedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedDeleteAllMessage(_ sender: Any) {
        
    }
    
}
