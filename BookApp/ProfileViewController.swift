//
//  ProfileViewController.swift
//  BookApp
//
//  Created by kien le van on 9/6/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationCustom: NavigationCustom!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var arraySetting = [ListSetting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getProfileTask: GetProfileMemberTask = GetProfileMemberTask(id: 1)
        requestWithTask(task: getProfileTask, success: { (data) in
            let member: ProfileMember = Constants.sharedInstance.memberProfile!
            self.avatar.sd_setImage(with: URL(string: member.avatar), placeholderImage: #imageLiteral(resourceName: "userPlaceHolder"))
            self.point.text = String(member.point)
            if member.level != 1 {
                self.status.text = "NO VIP"
            } else {
                self.status.text = "VIP"
            }
        }) { (error) in
            
        }
        
        customData()
        setupCallBack()
        table.register(UINib.init(nibName: "SettingViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
        avatar.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
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
        let cell: SettingViewCell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingViewCell
        let secsionObject = arraySetting[indexPath.section]
        cell.binData(settingCell: secsionObject.arr[indexPath.row])
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
         let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        if indexPath.section == 1 {
            let vc: VipDetailViewController = myStoryboard.instantiateViewController(withIdentifier: "VipDetailViewController") as! VipDetailViewController
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        if indexPath.row == 0 {
            let vc: ActivityOfflineViewController = myStoryboard.instantiateViewController(withIdentifier: "ActivityOfflineViewController") as! ActivityOfflineViewController
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let _mystoryBoard = UIStoryboard(name: "Setting", bundle: nil)
            let vc = _mystoryBoard.instantiateViewController(withIdentifier: "StoreMarkViewController")
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = myStoryboard.instantiateViewController(withIdentifier: "HistoryBuyProductController")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupCallBack() {
        navigationCustom.rightButton.setImage(#imageLiteral(resourceName: "ic_setting"), for: .normal)
        navigationCustom.callBackTopButton = { [weak self] (typeButton: TopButton) in
            switch typeButton {
            case TopButton.messageNotification:
                let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationMessageViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.videoNotification:
                let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationVideoViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.search:
                let myStoryboard = UIStoryboard(name: "Setting", bundle: nil)
                let vc: SettingViewController = myStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func pressedShowHistory(_ sender: Any) {
        let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc: HistoryWatchChanelViewController = myStoryboard.instantiateViewController(withIdentifier: "HistoryWatchChanelViewController") as! HistoryWatchChanelViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func pressedBookmark(_ sender: Any) {
        let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc: BookmarkedViewController = myStoryboard.instantiateViewController(withIdentifier: "BookmarkedViewController") as! BookmarkedViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pressedDownloaded(_ sender: Any) {
        let myStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc: DownloadedViewController = myStoryboard.instantiateViewController(withIdentifier: "DownloadedViewController") as! DownloadedViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
