//
//  DownloadedViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DownloadedViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    private var listChanelDownloaded: [Lesson] = []
    private var listBookDownloaded: [Book] = []
    private var oldlessonPlay: Int?
    private var oldBookPlay: Int?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    lazy var mp3 = MP3Player.shareIntanse
    private var firstShowDownload = true

    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "HistoryWatchChanelCell", bundle: nil), forCellReuseIdentifier: "chanelCell")
        table.register(UINib.init(nibName: "BookDownloadCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        getBookDownloaded()
        getLessonDownloaded()
    }
    
    func getBookDownloaded() {
        listBookDownloaded = Book.getBook()!
        table.reloadData()
    }
    
    func getLessonDownloaded() {
        listChanelDownloaded = Lesson.getLesson()!
        table.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "已下載"
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return listBookDownloaded.count
        } else {
            return listChanelDownloaded.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segment.selectedSegmentIndex == 0 {
            return bookCell(indexPath: indexPath)
        }
        return self.chanelCell(indexPath: indexPath)
    }
    
    func bookCell(indexPath: IndexPath) -> BookDownloadCell {
        let bookCell = table.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookDownloadCell
        let book = listBookDownloaded[indexPath.row]
        bookCell?.binData(book: book)
        bookCell?.callBackButton = { [weak self] (action: String) in
            switch action {
            case "playBook":
                self?.playAudioOfBook(book: book, current: indexPath.row)
                break
            case "removeBook":
                self?.pressRemoveBook(book: book)
                self?.listBookDownloaded.remove(at: indexPath.row)
                self?.table.reloadData()
                break
            default:
                break
            }
        }
        return bookCell!
    }
    
    func chanelCell(indexPath: IndexPath) -> HistoryWatchChanelCell {
        let chaneCell = table.dequeueReusableCell(withIdentifier: "chanelCell", for: indexPath) as? HistoryWatchChanelCell
        let lesson = listChanelDownloaded[indexPath.row]
        chaneCell?.binData(lesson: lesson)
        if mp3.oldIndexListPlay == indexPath.row {
            chaneCell?.imagePlay.image = #imageLiteral(resourceName: "audio_pause")
        } else {
            chaneCell?.imagePlay.image = #imageLiteral(resourceName: "audio_play")
        }
        chaneCell?.callBackButton = { [weak self] (action: String) in
            switch action {
            case "playChanel":
//                self?.playLeesonOfChanel(lesson: lesson, current: indexPath.row)
                self?.play(lesson: lesson, index: indexPath.row)
                break
            case "removeChanel":
                self?.listChanelDownloaded.remove(at: indexPath.row)
                self?.table.reloadData()
                break
            default:
                break
            }
        }
        return chaneCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func play(lesson: Lesson, index: Int) {
        if firstShowDownload {
            mp3.currentAudio = nil
            mp3.oldImdexDownloadlesson = index
            mp3.track(object: lesson)
            table.reloadData()
            firstShowDownload = false
            mp3.listPlay.append(lesson)
        }
        if let current = mp3.currentAudio as? Lesson {
            if lesson.idChap == current.idChap && mp3.isPlaying() {
                mp3.pause()
                mp3.oldImdexDownloadlesson = nil
                table.reloadData()
                return
            } else if lesson.idChap == current.idChap && !mp3.isPlaying() {
                mp3.play()
                mp3.oldImdexDownloadlesson = index
                table.reloadData()
                return
            }
        }
    }
    
//    func playLeesonOfChanel(lesson: Lesson, current: Int) {
//        if lesson.isPlay == 1 {
//            if  player?.rate == 1 {
//                lesson.pause = 1
//                player?.pause()
//            } else {
//                lesson.pause = 0
//                player?.play()
//            }
//            self.table.reloadData()
//            return
//        }
//        player = nil
//        if oldlessonPlay != nil {
//            listChanelDownloaded[(oldlessonPlay!)].isPlay = 0
//            listChanelDownloaded[oldlessonPlay!].pause = 0
//        }
//        oldlessonPlay = current
//        lesson.isPlay = 1
//        playerItem = AVPlayerItem(url: lesson.audioOffline)
//        player = AVPlayer(playerItem: playerItem)
//        player?.play()
//        table.reloadData()
//    }
    
    func pressRemoveBook(book: Book) {
        var listBook: [Book] = Book.getBook()!
        for index in 0..<listBook.count where listBook[index].idBook == book.idBook {
            listBook.remove(at: index)
        }
        Book.saveBook(myBook: listBook)
    }
    
    func playAudioOfBook(book: Book, current: Int) {
        if book.isPlay == 1 {
            if  player?.rate == 1 {
                book.pause = 1
                player?.pause()
            } else {
                book.pause = 0
                player?.play()
            }
            self.table.reloadData()
            return
        }
        player = nil
        if oldBookPlay != nil {
            listBookDownloaded[(oldBookPlay!)].isPlay = 0
            listBookDownloaded[oldBookPlay!].pause = 0
        }
        oldBookPlay = current
        book.isPlay = 1
        playerItem = AVPlayerItem(url: book.audioOffline!)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        table.reloadData()
    }
    
    @IBAction func pressedSegment(_ sender: Any) {
        table.reloadData()
    }
}
