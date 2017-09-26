//
//  NotificationVideoViewController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class HistoryPlayAudioController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var listHistoryAudio: [Book] = []
    var downloadImageSuccess = false
    var downloadAuidosucess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        listHistoryAudio = Constants.sharedInstance.historyViewAudio
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHistoryAudio.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "HistoryPlayAudioCell", for: indexPath) as? HistoryPlayAudioCell
        cell?.bindData(historyBook: listHistoryAudio[indexPath.row])
        cell?.callBackDownload = { [weak self] book in
            self?.downloadAudio(book: book)
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
