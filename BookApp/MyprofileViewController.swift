//
//  MyprofileViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class MyprofileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    var arraySetting = [ListSetting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = "Back"
        navigationController?.navigationBar.backItem?.title = "Back"
        table.register(UINib.init(nibName: "SettingViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
        customData()
    }

    func customData() {
        let setting1 = SettingCellModel(name: "1", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting2 = SettingCellModel(name: "2", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting3 = SettingCellModel(name: "3", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting4 = SettingCellModel(name: "4", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting5 = SettingCellModel(name: "", specialName: "hello", arrrowDetail: false, nameDetail: "")
        
        let arraySetting1 = ListSetting(array: [setting1, setting2, setting3, setting4])
        let arraySetting2 = ListSetting(array: [setting5])
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
        height.adjustsSizeToRealIPhoneSize = 15
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var height: CGFloat = 15
        height.adjustsSizeToRealIPhoneSize = 15
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: height))
        headerView.backgroundColor = UIColor.clear
        return headerView
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }

}
