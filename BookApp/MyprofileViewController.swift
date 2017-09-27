//
//  MyprofileViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class MyprofileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    var arraySetting: [ListSetting] = []
    let memberProfile = Constants.sharedInstance.memberProfile
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        setupNavigationBar()
        table.register(UINib.init(nibName: "SettingViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
        avatar.sd_setImage(with: URL(string: (memberProfile?.avatar)!), placeholderImage: #imageLiteral(resourceName: "place_holder"))
        customData()
    }
    
    func setupNavigationBar() {
        let label = UILabel(frame: CGRect(x:0, y:0, width:150, height:50))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor.rgb(red: 82, green: 82, blue: 82)
        label.text = "個人信息\n會員編號: 123456789"
        navigationItem.titleView = label
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToRootView))
    }
    
    func backToRootView() {
        navigationController?.popToRootViewController(animated: true)
    }

    func customData() {
        let setting1 = SettingCellModel(name: "姓名", specialName: "", arrrowDetail: true, nameDetail: (memberProfile?.name)!)
        let setting2 = SettingCellModel(name: "郵箱", specialName: "", arrrowDetail: true, nameDetail: (memberProfile?.email)!)
        let setting3 = SettingCellModel(name: "密碼", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting4 = SettingCellModel(name: "完善資料", specialName: "", arrrowDetail: true, nameDetail: "")
        let setting5 = SettingCellModel(name: "", specialName: "退出登錄", arrrowDetail: false, nameDetail: "")
//
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
        if let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingViewCell {
            let secsionObject = arraySetting[indexPath.section]
            cell.name.textColor = UIColor.black
            cell.specialName.textColor = UIColor.black
            cell.binData(settingCell: secsionObject.arr[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            print("logout")
            return
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ChangeProfileViewController") as? ChangeProfileViewController {
            switch indexPath.row {
            case TypeView.name.rawValue:
                vc.typeViewShow = TypeView.name
            case TypeView.email.rawValue:
                vc.typeViewShow = TypeView.email
            case TypeView.pass.rawValue:
                vc.typeViewShow = TypeView.pass
            case TypeView.information.rawValue:
                vc.typeViewShow = TypeView.information
            default:
                break
            }
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            avatar.image = chosenImage //4
            dismiss(animated:true, completion: nil) //5
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func pickImageFromLibrary() {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
//        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    func shootAvatar() {
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func pressedChangeAvatar(_ sender: Any) {
        _ = UIAlertController.showActionSheetWith(arrayTitle: ["拍照", "從相冊選擇"],
                                                  handlerAction: { (index) in
                                                    switch index {
                                                    case 0:
                                                        self.shootAvatar()
                                                    case 1:
                                                        self.pickImageFromLibrary()
                                                    default:
                                                        break
                                                    }
            }, in: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
