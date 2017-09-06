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
    
    var arraySpectical = [ObjectProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customData()
        setupCallBack()
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
        avatar.layer.borderColor = UIColor.white.cgColor
    }
    
    func customData() {
        let array1 = ObjectProfile(array: ["1", "2", "3", "4"])
        let array2 = ObjectProfile(array: ["5"])
        arraySpectical.append(array1)
        arraySpectical.append(array2)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arraySpectical.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySpectical[section].arr.count
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
        let cell: ProfileViewCell = table.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        let secsionObject = arraySpectical[indexPath.section]
        cell.binData(nameLabel: secsionObject.arr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func setupCallBack() {
        navigationCustom.callBackTopButton = { [weak self] (typeButton: TopButton) in
            let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
            switch typeButton {
            case TopButton.messageNotification:
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationMessageViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.videoNotification:
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationVideoViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.search:
                let vc: SearchViewController = myStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
}

class ObjectProfile: NSObject {

    private let _arr: [String]!
    
    init(array: [String]) {
        _arr = array
    }
    var arr: [String] {
        return _arr
    }
}
