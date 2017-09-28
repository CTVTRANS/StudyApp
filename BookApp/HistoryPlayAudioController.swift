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
    var listHistory: [AnyObject] = []
    var downloadImageSuccess = false
    var downloadAuidosucess = false
    var asset: AVAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        listHistory = Constants.sharedInstance.historyViewAudio
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "HistoryPlayAudioCell", for: indexPath) as? HistoryPlayAudioCell
        cell?.bindData(historyObject: listHistory[indexPath.row])
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
            self?.playAudio(object: object, current: indexPath.row)
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
    
    func playAudio(object: AnyObject, current: Int) {
        if (object as? Book) != nil {
            if (object as? Book)?.isPlay == 1 {
                if  Constants.sharedInstance.player?.rate == 1 {
                    (object as? Book)?.pause = 1
                    Constants.sharedInstance.player?.pause()
                } else {
                    (object as? Book)?.pause = 0
                    Constants.sharedInstance.player?.play()
                }
                self.table.reloadData()
                return
            }
            Constants.sharedInstance.player = nil
            if oldObjectPlay != nil {
                (listHistory[(oldObjectPlay!)] as? Book)?.isPlay = 0
                (listHistory[(oldObjectPlay!)] as? Book)?.pause = 0
            }
            
            (object as? Book)?.isPlay = 1
            asset = AVAsset(url: URL(string: ((object as? Book)?.audio)!)!)
        }
        
        if (object as? Lesson) != nil {
            if (object as? Lesson)?.isPlay == 1 {
                if  Constants.sharedInstance.player?.rate == 1 {
                    (object as? Lesson)?.pause = 1
                    Constants.sharedInstance.player?.pause()
                } else {
                    (object as? Lesson)?.pause = 0
                    Constants.sharedInstance.player?.play()
                }
                self.table.reloadData()
                return
            }
            Constants.sharedInstance.player = nil
            if oldObjectPlay != nil {
                (listHistory[(oldObjectPlay!)] as? Lesson)?.isPlay = 0
                (listHistory[(oldObjectPlay!)] as? Lesson)?.pause = 0
            }
           
            (object as? Lesson)?.isPlay = 1
            asset = AVAsset(url: URL(string: ((object as? Lesson)?.contentURL)!)!)
        }
        oldObjectPlay = current
        let keys: [String] = ["audio"]
        asset?.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                Constants.sharedInstance.playerItem = AVPlayerItem(asset: self.asset!)
                Constants.sharedInstance.player =
                    AVPlayer(playerItem:  Constants.sharedInstance.playerItem)
                Constants.sharedInstance.player?.play()
            }
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
