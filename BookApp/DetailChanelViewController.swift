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

    // MARK: Property UI
    
    @IBOutlet weak var bottomView: BottomView!
    @IBOutlet weak var topViewShare: TopViewShare!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var chanelImage: UIImageView!
    @IBOutlet weak var nameTeacher: UILabel!
    @IBOutlet weak var chaneType: UILabel!
    @IBOutlet weak var numberView: UILabel!
    
    @IBOutlet weak var downloadAllButton: UIButton!
    @IBOutlet weak var subcribedTeacher: UIButton!
    @IBOutlet weak var heightImageChanel: NSLayoutConstraint!
    
    // MARK: Property Control
    
    var chanel: Chanel!
    private var lessonUploaded = [Lesson]()
    private var loadedListLessonUpload = false
    private var loadedNumberView = false
    private var downloadImageSucess = true
    private var downloadAudioSucess = false
    
    private var oldlessonPlay: Int?
    
    lazy var footerView = UIView.initFooterView()
    private var indicator: UIActivityIndicatorView?
    var isMoreData = true
    var isLoading = false
    var pager = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
        showActivity(inView: self.view)
        setupUI()
        setupTopShare()
        setupCallBackBottom()
        checkSubcribleed()
        getDataFromServer()
        var heightHeader: CGFloat = 188
        heightHeader.adjustsSizeToRealIPhoneSize = 188
        table.tableHeaderView?.frame.size.height = heightHeader
        if let ac = footerView.viewWithTag(8) as? UIActivityIndicatorView {
            indicator = ac
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: UI
    
    func setupUI() {
        downloadAllButton.layer.borderColor = UIColor.rgb(red: 254, green: 153, blue: 0).cgColor
        subcribedTeacher.layer.borderColor = UIColor.rgb(red: 254, green: 153, blue: 0).cgColor
        table.tableFooterView = UIView()
        
        chanelImage.sd_setImage(with: URL(string: chanel.imageTeacherURL))
        chanelImage.layer.cornerRadius = heightImageChanel.constant / 2
        chaneType.text = chanel.typeChanel
        nameTeacher.text = chanel.nameTeacher
        
        bottomView.hiddenBottom()
    }
    
    func setupTopShare() {
        topViewShare.titleTop.text = chanel.nameChanel
        if self.revealViewController() != nil {
            revealViewController().rightViewRevealWidth = 80
            topViewShare.shareButton.addTarget(self.revealViewController(), action: #selector(revealViewController().rightRevealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    // MARK: Get Data
    
    func getDataFromServer() {
        let getNumberView: GetTotaViewOfChanel = GetTotaViewOfChanel(chanelID: chanel.idChanel)
        requestWithTask(task: getNumberView, success: { (data) in
            if let numberViewChanel = data as? Int {
                self.chanel.numberView = numberViewChanel
                self.numberView.text = String(numberViewChanel)
                self.loadedNumberView = true
                if self.loadedNumberView && self.loadedListLessonUpload {
                    self.stopActivityIndicator()
                }
            }
        }) { (_) in
            
        }
        loadMore()
    }
    
    func checkSubcribleed() {
        let allChanelSubcrible: [Chanel] = Constants.sharedInstance.listChanelSubcribled
        for chanelSubcribled in allChanelSubcrible where chanel.idChanel == chanelSubcribled.idChanel {
            subcribedTeacher.setTitle("  已訂閱頻道  ", for: .normal)
            subcribedTeacher.isEnabled = false
        }
    }

    // MARK: Table Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonUploaded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChanelUpLoaeCell", for: indexPath) as? ChanelUpLoaeCell {
            let lesson: Lesson = lessonUploaded[indexPath.row]
            lesson.chanelOwner = chanel.nameChanel
            cell.binData(chap: lesson)
            cell.callBackButton = { [weak self] (typeButton: String) in
                switch typeButton {
                case "download":
                    self?.pressedDownload(lesson: lesson)
                case "play":
                    self?.playAudio(lesson: lesson, current: indexPath.row)
                default :
                    return
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: Table Delegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endOftable = table.contentOffset.y >= (table.contentSize.height - table.frame.size.height)
        if isMoreData && endOftable && !isLoading && !scrollView.isDragging && !scrollView.isDecelerating {
            isLoading = true
            table.tableFooterView = footerView
            indicator?.startAnimating()
            loadMore()
        }
    }
    
    func loadMore() {
        let getLesson: GetListlessonOfChanelTask =
            GetListlessonOfChanelTask(chanelID: chanel.idChanel,
                                      page: pager)
        requestWithTask(task: getLesson, success: { (data) in
            if let arrayLesson = data as? [Lesson] {
                self.lessonUploaded  += arrayLesson
                self.table.reloadData()
                self.loadedListLessonUpload = true
                if self.loadedNumberView && self.loadedListLessonUpload {
                    self.stopActivityIndicator()
                }
                self.pager += 1
                self.isLoading = false
                self.indicator?.stopAnimating()
                if arrayLesson.count == 0 {
                    self.isMoreData = false
                }
            }
        }) { (error) in
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    
    // MARK: Play Music
    
    func playAudio(lesson: Lesson, current: Int) {
        if lesson.isPlay == 1 {
            if  Constants.sharedInstance.player?.rate == 1 {
                lesson.pause = 1
                Constants.sharedInstance.player?.pause()
            } else {
                lesson.pause = 0
                Constants.sharedInstance.player?.play()
            }
            self.table.reloadData()
            return
        }
        Constants.sharedInstance.player = nil
        lesson.chanelOwner = chanel.nameChanel
        Constants.sharedInstance.historyViewChanelLesson.append(lesson)
        if oldlessonPlay != nil {
            lessonUploaded[(oldlessonPlay!)].isPlay = 0
            lessonUploaded[(oldlessonPlay!)].pause = 0
        }
        oldlessonPlay = current
        lesson.isPlay = 1
        let viewed: IncreaseVIewChanelTask = IncreaseVIewChanelTask(lessonID: lesson.idChap)
        requestWithTask(task: viewed, success: { (data) in
            if let status = data as? String {
                if status == "success" {
                    self.chanel.numberView += 1
                    let numberView = self.chanel.numberView
                    self.numberView.text = String(numberView)
                    self.table.reloadData()
                }
            }
        }) { (_) in
            
        }
        let asset = AVAsset(url: URL(string: lesson.contentURL)!)
        let keys: [String] = ["audio"]
        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.main.async {
                Constants.sharedInstance.playerItem = AVPlayerItem(asset: asset)
                Constants.sharedInstance.player =
                    AVPlayer(playerItem:  Constants.sharedInstance.playerItem)
                Constants.sharedInstance.player?.play()
            }
        }
    }
    
    // MARK: Button Control
    
    func setupCallBackBottom() {
        bottomView.pressedBottomButton = { [weak self] typeButton in
            if typeButton == BottomButton.comment {
                let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
                let vc = myStoryboard.instantiateViewController(withIdentifier: "CommentController") as? CommentController
                self?.present(vc!, animated: false, completion: nil)
            }
        }
    }
    
    func pressedDownload(lesson: Lesson) {
        lesson.chanelOwner = chanel.nameChanel
        let downloadImageLesson = DownloadTask(path: lesson.imageChapURL)
        downloadFileSuccess(task: downloadImageLesson, success: { (data) in
            if let imageOffline = data as? URL {
                lesson.imageOffline = imageOffline
                self.downloadImageSucess = true
                if self.downloadImageSucess && self.downloadAudioSucess {
                    self.setListLesson(chap: lesson)
                }
            }
        }) { (_) in
        }
        
        let downloadLesson = DownloadTask(path: lesson.contentURL)
        downloadFileSuccess(task: downloadLesson, success: { (data) in
            if let audioOffline = data as? URL {
                lesson.audioOffline = audioOffline
                self.downloadAudioSucess = true
                if self.downloadImageSucess && self.downloadAudioSucess {
                    self.setListLesson(chap: lesson)
                }
            }
        }) { (_) in
        }
    }
    
    func setListLesson(chap: Lesson) {
        var listLesson = Lesson.getLesson()
        for singleLesson in listLesson! where chap.idChap == singleLesson.idChap {
            return
        }
        listLesson?.append(chap)
        Lesson.saveLesson(lesson: listLesson!)
        print("sucess")
    }
    
    @IBAction func pressedSubcribeButton(_ sender: Any) {
        let subcrible: SubcribleChanelTask = SubcribleChanelTask(memberID: 1, chanelID: chanel.idChanel)
        requestWithTask(task: subcrible, success: { (data) in
            if let status: Subcrible = data as? Subcrible {
                if status == Subcrible.subcrible {
                    Constants.sharedInstance.listChanelSubcribled.append(self.chanel)
                    self.subcribedTeacher.setTitle("  已訂閱頻道  ", for: .normal)
                    self.subcribedTeacher.isEnabled = false
                }
            }
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedDownloadAll(_ sender: Any) {
        for singleLesson in lessonUploaded {
            pressedDownload(lesson: singleLesson)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
