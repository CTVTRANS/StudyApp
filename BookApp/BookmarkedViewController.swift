//
//  BookmarkedViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class BookmarkedViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    private var listBookMarkOfBook: [Book] = []
    private var listBookMarkOfNews: [NewsModel] = []
    
    private var oldBookPlay: Int?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "BookDownloadCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        getBookBookmarked()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "我的收藏"
        navigationController?.setNavigationBarHidden(false, animated: animated)
        getNewsBookmarked()
    }
    
    func getNewsBookmarked() {
        let getNewsTask = GetAllNewsBookmarkedTask(page: 1)
        requestWithTask(task: getNewsTask, success: { (data) in
            if let listNews = data as? [NewsModel] {
                self.listBookMarkOfNews = listNews
                self.table.reloadData()
            }
        }) { (_) in
            
        }
    }
    
    func getBookBookmarked() {
        let getBookTask = GetAllBookBookmarkedTask(page: 1)
        requestWithTask(task: getBookTask, success: { (data) in
            if let listBook = data as? [Book] {
                self.listBookMarkOfBook = listBook
                self.table.reloadData()
            }
        }) { (_) in
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return listBookMarkOfNews.count
        } else {
            return listBookMarkOfBook.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segment.selectedSegmentIndex == 0 {
            return newsCells(indexPath: indexPath)
        } else {
            return bookCells(indexPath: indexPath)
        }
    }
    
    func newsCells(indexPath: IndexPath) -> NewsBookmarkedCell {
        let newsCell = table.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsBookmarkedCell
        newsCell?.binData(news: listBookMarkOfNews[indexPath.row])
        return newsCell!
    }
    
    func bookCells(indexPath: IndexPath) -> BookDownloadCell {
        let bookCell = table.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookDownloadCell
        let book = listBookMarkOfBook[indexPath.row]
        bookCell?.binData(book: book)
        bookCell?.callBackButton = { [weak self] (action: String) in
            switch action {
            case "playBook":
                self?.playAudioOfBook(book: book, current: indexPath.row)
                break
            case "removeBook":
                self?.removeBookmark(indexPath: indexPath)
                self?.table.reloadData()
                break
            default:
                break
            }
        }
        return bookCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        if segment.selectedSegmentIndex == 0 {
            let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let type = listBookMarkOfNews[indexPath.row].typeNews
            if type == 1 {
                let vc = myStoryBoard.instantiateViewController(withIdentifier: "Detail") as? DetailNewsController
                vc?.news = listBookMarkOfNews[indexPath.row]
                navigationController?.pushViewController(vc!, animated: true)
            } else if type == 2 {
                let vc = myStoryBoard.instantiateViewController(withIdentifier: "Type2Detail") as? Type2DetailNewsViewController
                vc?.news = listBookMarkOfNews[indexPath.row]
                navigationController?.pushViewController(vc!, animated: true)
            } else {
                let vc = myStoryBoard.instantiateViewController(withIdentifier: "Type3DetailNewsController") as? Type3DetailNewsController
                vc?.news = listBookMarkOfNews[indexPath.row]
                navigationController?.pushViewController(vc!, animated: true)
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
            listBookMarkOfBook[(oldBookPlay!)].isPlay = 0
            listBookMarkOfBook[oldBookPlay!].pause = 0
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
    
    func removeBookmark(indexPath: IndexPath) {
        let removeBookmarkTask = BookMarkTask(bookMarkType: Object.book.rawValue,
                                              memberID: 1,
                                              objectId: listBookMarkOfBook[indexPath.row].idBook)
        requestWithTask(task: removeBookmarkTask, success: { (_) in
            self.listBookMarkOfBook.remove(at: indexPath.row)
            self.table.reloadData()
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedSegment(_ sender: Any) {
        table.reloadData()
    }
}
