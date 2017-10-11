//
//  ProfileViewController.swift
//  BookApp
//
//  Created by kien le van on 9/6/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var navigationCustom: NavigationCustom!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameMember: UILabel!
    var arraySetting = [ListSetting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customData()
        setupCallBack()
        table.register(UINib.init(nibName: "SettingViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
        avatar.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkMember()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Setup UI
    
    func customData() {
        let setting1 = SettingCellModel(name: "線下活動", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting2 = SettingCellModel(name: "積分商城", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting3 = SettingCellModel(name: "購物記錄", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting4 = SettingCellModel(name: "會員狀態", specialName: "", arrrowDetail: true, nameDetail: "")
        let arraySetting1 = ListSetting(array: [setting1, setting2, setting3])
        let arraySetting2 = ListSetting(array: [setting4])
        arraySetting.append(arraySetting1)
        arraySetting.append(arraySetting2)
    }
    
    func checkMember() {
        if !checkLogin() {
            profileView.isHidden = true
            loginButton.setTitle("SigIn", for: .normal)
            return
        }
        loginButton.setTitle("Attendance", for: .normal)
        profileView.isHidden = false
        let member = ProfileMember.getProfile()!
        let avatarURL = member.avatar! + "?"
        self.avatar.sd_setImage(with: URL(string: avatarURL), placeholderImage: #imageLiteral(resourceName: "userPlaceHolder"))
        self.point.text = String(member.point)
        nameMember.text = member.name
        if member.level != 1 {
            self.status.text = "NO VIP"
        } else {
            self.status.text = "VIP"
        }
    }
    
    // MARK: Table Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arraySetting.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySetting[section].arr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 15
        if section == 0 {
            height.adjustsSizeToRealIPhoneSize = 15
            return height
        } else {
            height.adjustsSizeToRealIPhoneSize = 55
            return height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 37
        height.adjustsSizeToRealIPhoneSize = 37
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingViewCell {
            let secsionObject = arraySetting[indexPath.section]
            cell.binData(settingCell: secsionObject.arr[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var height: CGFloat = 15
        if section == 0 {
            height.adjustsSizeToRealIPhoneSize = 15
        } else {
            height.adjustsSizeToRealIPhoneSize = 55
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: height))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // MARK: Table Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
         let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        if indexPath.section == 1 {
            if let vc = myStoryboard.instantiateViewController(withIdentifier: "VipDetailViewController") as? VipDetailViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            return
        }
        if indexPath.row == 0 {
            if let vc = myStoryboard.instantiateViewController(withIdentifier: "ActivityOfflineViewController") as? ActivityOfflineViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.row == 1 {
            let _mystoryBoard = UIStoryboard(name: "Setting", bundle: nil)
            let vc = _mystoryBoard.instantiateViewController(withIdentifier: "StoreMarkViewController")
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = myStoryboard.instantiateViewController(withIdentifier: "HistoryBuyProductController")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: Button Control
    
    func setupCallBack() {
        navigationCustom.rightButton.setImage(#imageLiteral(resourceName: "ic_setting"), for: .normal)
        navigationCustom.callBackTopButton = { [weak self] (typeButton: TopButton) in
            if typeButton == TopButton.search {
                let myStoryboard = UIStoryboard(name: "Setting", bundle: nil)
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController {
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            if !(self?.checkLogin())! {
                self?.goToSigIn()
                return
            }
            switch typeButton {
            case TopButton.messageNotification:
               self?.goToNotification()
            case TopButton.videoNotification:
                self?.goToListPlayaudio()
            default :
                break
            }
        }
    }
    
    @IBAction func pressedShowHistory(_ sender: Any) {
        let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = myStoryboard.instantiateViewController(withIdentifier: "HistoryWatchChanelViewController") as? HistoryWatchChanelViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func pressedBookmark(_ sender: Any) {
        let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = myStoryboard.instantiateViewController(withIdentifier: "BookmarkedViewController") as? BookmarkedViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func pressedDownloaded(_ sender: Any) {
        let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        if let vc = myStoryboard.instantiateViewController(withIdentifier: "DownloadedViewController") as? DownloadedViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func pressedLoginButton(_ sender: Any) {
        if checkLogin() {
            let member = ProfileMember.getProfile()
            let token = ProfileMember.getToken()
            let updatepoint = UpdatePointTask(memberID: (member?.idMember)!,
                                              token: token!,
                                              type: UpdatePointType.attendance.rawValue)
            requestWithTask(task: updatepoint, success: { (data) in
                if let status = data as? (Bool, Int) {
                    if status.0 {
                        self.loginButton.setTitle("Attendanced", for: .normal)
                    }
                    self.point.text = String(status.1)
                }
            }, failure: { (_) in
                
            })
        } else {
            goToSigIn()
        }
    }
}

enum UpdatePointType: Int {
    case share = 0, attendance
}
