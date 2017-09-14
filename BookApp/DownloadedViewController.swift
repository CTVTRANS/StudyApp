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
    var listChanelDownloaded: [Lesson] = []
    var listBookDownloaded: [Book] = []
    private var oldlessonPlay: Int?
    private var oldBookPlay: Int?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "HistoryWatchChanelCell", bundle: nil), forCellReuseIdentifier: "chanelCell")
        table.register(UINib.init(nibName: "BookDownloadCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        listBookDownloaded = Constants.sharedInstance.listDownloadBook
        listChanelDownloaded = Constants.sharedInstance.listDownloadLesson
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
        let chaneCell: HistoryWatchChanelCell = table.dequeueReusableCell(withIdentifier: "chanelCell", for: indexPath) as! HistoryWatchChanelCell
        let lesson = listChanelDownloaded[indexPath.row]
        chaneCell.binData(lesson: lesson)
        if lesson.isPlay == 1 {
            if lesson.pause == 1 {
                chaneCell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
            } else {
                chaneCell.imagePlay.image = #imageLiteral(resourceName: "audio_pause")
            }
        } else {
            chaneCell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
        }
        chaneCell.callBackButton = { [weak self] (action: String) in
            switch action {
            case "playChanel":
                self?.playLeesonOfChanel(lesson: lesson, current: indexPath.row)
                break
            case "removeChanel":
                self?.listChanelDownloaded.remove(at: indexPath.row)
                self?.table.reloadData()
                break
            default:
                break
            }
        }
        let bookCell: BookDownloadCell = table.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookDownloadCell
        let book = listBookDownloaded[indexPath.row]
        bookCell.binData(book: book)
        if book.isPlay == 1 {
            if book.pause == 1 {
                bookCell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
            } else {
                bookCell.imagePlay.image = #imageLiteral(resourceName: "audio_pause")
            }
        } else {
            bookCell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
        }
        bookCell.callBackButton = { [weak self] (action: String) in
            switch action {
            case "playBook":
                self?.playAudioOfBook(book: book, current: indexPath.row)
                break
            case "removeBook":
                self?.listBookDownloaded.remove(at: indexPath.row)
                self?.table.reloadData()
                break
            default:
                break
            }
        }
        
        if segment.selectedSegmentIndex == 0 {
            return bookCell
        } else {
            return chaneCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func playLeesonOfChanel(lesson: Lesson, current: Int) {
        if lesson.isPlay == 1 {
            if  player?.rate == 1 {
                lesson.pause = 1
                player?.pause()
            } else {
                lesson.pause = 0
                player?.play()
            }
            self.table.reloadData()
            return
        }
        player = nil
        if oldlessonPlay != nil {
            listChanelDownloaded[(oldlessonPlay!)].isPlay = 0
            listChanelDownloaded[oldlessonPlay!].pause = 0
        }
        oldlessonPlay = current
        lesson.isPlay = 1
        let asset = AVAsset(url: URL(string: lesson.contentURL)!)
        let keys: [String] = ["audio"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                self.playerItem = AVPlayerItem(asset: asset)
                self.player = AVPlayer(playerItem: self.playerItem)
                self.player?.play()
                self.table.reloadData()
            }
        }
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
        let asset = AVAsset(url: URL(string: book.audio)!)
        let keys: [String] = ["audio"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                self.playerItem = AVPlayerItem(asset: asset)
                self.player = AVPlayer(playerItem: self.playerItem)
                self.player?.play()
                self.table.reloadData()
            }
        }
    }
    
    @IBAction func pressedSegment(_ sender: Any) {
        table.reloadData()
    }
    
}
