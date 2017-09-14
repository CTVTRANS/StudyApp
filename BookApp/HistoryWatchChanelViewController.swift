//
//  HistoryWatchChanelViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class HistoryWatchChanelViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    var listHistoryLesson: [Lesson] = []
    private var oldlessonPlay: Int?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "HistoryWatchChanelCell", bundle: nil), forCellReuseIdentifier: "cell")
        listHistoryLesson = Constants.sharedInstance.historyViewChanelLesson
        for historyLesson in listHistoryLesson {
            historyLesson.isPlay = 0
            historyLesson.pause = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "播放記錄"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHistoryLesson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryWatchChanelCell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryWatchChanelCell
        let lesson = listHistoryLesson[indexPath.row]
        cell.binData(lesson: lesson)
        if lesson.isPlay == 1 {
            if lesson.pause == 1 {
                cell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
            } else {
                cell.imagePlay.image = #imageLiteral(resourceName: "audio_pause")
            }
        } else {
            cell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
        }
        cell.callBackButton = { [weak self] (action: String) in
            switch action {
            case "playChanel":
                self?.playLeesonOfChanel(lesson: lesson, current: indexPath.row)
                break
            case "removeChanel":
                Constants.sharedInstance.historyViewChanelLesson.remove(at: indexPath.row)
                self?.listHistoryLesson = Constants.sharedInstance.historyViewChanelLesson
                self?.table.reloadData()
                break
            default:
                break
            }
        }
        return cell
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
            listHistoryLesson[(oldlessonPlay!)].isPlay = 0
            listHistoryLesson[oldlessonPlay!].pause = 0
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
    
    

}
