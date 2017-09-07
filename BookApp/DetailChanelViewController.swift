//
//  DetailTeacherViewController.swift
//  BookApp
//
//  Created by kien le van on 8/14/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DetailChanelViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topViewShare: TopViewShare!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var chanelImage: UIImageView!
    @IBOutlet weak var nameTeacher: UILabel!
    @IBOutlet weak var chaneType: UILabel!
    @IBOutlet weak var numberView: UILabel!
    
    @IBOutlet weak var downloadAllButton: UIButton!
    @IBOutlet weak var subcribedTeacher: UIButton!
    @IBOutlet weak var heightImageChanel: NSLayoutConstraint!

    var chanel: Chanel!
    private var lessonUploaded = [Lesson]()
    private var loadedListLessonUpload = false
    private var loadedNumberView = false
    private var currentlesson: Int?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
        showActivity(inView: self.view)
        setupUI()
        checkSubcribleed()
        getDataFromServer()
        var heightHeader: CGFloat = 188
        heightHeader.adjustsSizeToRealIPhoneSize = 188
        table.tableHeaderView?.frame.size.height = heightHeader
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupUI() {
        downloadAllButton.layer.borderColor = UIColor.rgb(r: 254, g: 153, b: 0).cgColor
        subcribedTeacher.layer.borderColor = UIColor.rgb(r: 254, g: 153, b: 0).cgColor
        table.tableFooterView = UIView()
        
        chanelImage.sd_setImage(with: URL(string: chanel.imageTeacherURL))
        chanelImage.layer.cornerRadius = heightImageChanel.constant / 2
        topViewShare.titleTop.text = chanel.nameChanel
        chaneType.text = chanel.typeChanel
        nameTeacher.text = chanel.nameTeacher
    }
    
    func getDataFromServer() {
        let getNumberView: GetTotaViewOfChanel = GetTotaViewOfChanel(chanelID: chanel.idChanel)
        requestWithTask(task: getNumberView, success: { (data) in
            self.chanel.numberView = data as! Int
            self.numberView.text = String(self.chanel.numberView)
            self.loadedNumberView = true
            if self.loadedNumberView && self.loadedListLessonUpload {
                self.stopActivityIndicator()
            }
        }) { (error) in
            
        }
        let getLesson: GetListlessonOfChanelTask =
            GetListlessonOfChanelTask(chanelID: chanel.idChanel,
                                      limit: 10,
                                      page: 1)
        requestWithTask(task: getLesson, success: { (data) in
            self.lessonUploaded = data as! [Lesson]
            self.table.reloadData()
            self.loadedListLessonUpload = true
            if self.loadedNumberView && self.loadedListLessonUpload {
                self.stopActivityIndicator()
            }
        }) { (error) in
            
        }
    }
    
    func checkSubcribleed() {
        for chanelSubcribled in Constants.sharedInstance.listChanelSubcribled! {
            if chanel.idChanel == chanelSubcribled.idChanel {
                subcribedTeacher.setTitle("subcribled", for: .normal)
                subcribedTeacher.isEnabled = false
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonUploaded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChanelUpLoaeCell = tableView.dequeueReusableCell(withIdentifier: "ChanelUpLoaeCell", for: indexPath) as! ChanelUpLoaeCell
        let lesson: Lesson = lessonUploaded[indexPath.row]
        cell.binData(chap: lesson)
        if lesson.isPlay == 1 {
            cell.imagePlay.image = #imageLiteral(resourceName: "audio_pause")
        } else {
            cell.imagePlay.image = #imageLiteral(resourceName: "audio_play")
        }
        cell.callBackButton = { [weak self] (typeButton: String) in
            switch typeButton {
            case "download":
                print("download")
            case "play":
                self?.playAudio(lesson: lesson, oldLessonPlay: indexPath.row)
            default :
                return
            }
        }
        return cell
    }
    
    func playAudio(lesson: Lesson, oldLessonPlay: Int) {
        player = nil
        if lesson.isPlay == 1 {
            lesson.isPlay = 0
            self.table.reloadData()
            return
        }
        if currentlesson != nil {
            lessonUploaded[(currentlesson!)].isPlay = 0
        }
        currentlesson = oldLessonPlay
        lesson.isPlay = 1
        let viewed: IncreaseVIewChanelTask = IncreaseVIewChanelTask(lessonID: lesson.idChap)
        requestWithTask(task: viewed, success: { (data) in
            let status = data as! String
            if status == "success" {
                self.chanel.numberView += 1
                let numberView = self.chanel.numberView
                self.numberView.text = String(numberView)
                self.table.reloadData()
            }
        }) { (error) in
            
        }
        let asset = AVAsset(url: URL(string: lesson.contentURL)!)
        let keys: [String] = ["audio"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                self.playerItem = AVPlayerItem(asset: asset)
                self.player = AVPlayer(playerItem: self.playerItem)
                self.player?.play()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func pressedSubcribeButton(_ sender: Any) {
        let subcrible: SubcribleChanelTask = SubcribleChanelTask(memberID: 1, chanelID: chanel.idChanel)
        requestWithTask(task: subcrible, success: { (data) in
            let status: Subcrible = data as! Subcrible
            if status == Subcrible.subcrible {
                self.subcribedTeacher.setTitle("subcriblred", for: .normal)
                self.subcribedTeacher.isEnabled = false
            }
        }) { (error) in
            
        }
    }
    
    @IBAction func pressedDownloadAll(_ sender: Any) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
