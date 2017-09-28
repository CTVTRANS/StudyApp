//
//  ChangeProfileViewController.swift
//  BookApp
//
//  Created by kien le van on 9/14/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

enum TypeView: Int {
    case name = 0, email, pass, information
}

class ChangeProfileViewController: BaseViewController {
    
    @IBOutlet weak var infomationView: UIView!
    @IBOutlet weak var passWordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var userNameView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPassTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var birthDay: UILabel!
    @IBOutlet weak var statusMarrie: UILabel!
    
    @IBOutlet weak var hobby: UITextField!
    @IBOutlet weak var occupation: UITextField!
    
    var typeViewShow: TypeView = TypeView(rawValue: 0)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infomationView.isHidden = true
        passWordView.isHidden = true
        emailView.isHidden = true
        userNameView.isHidden = true
        showView(tyepViewNeedShow: typeViewShow)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        let rightButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveInfomation))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func showView(tyepViewNeedShow: TypeView) {
        switch tyepViewNeedShow {
        case .name:
            infomationView.removeFromSuperview()
            userNameView.isHidden = false
        case .email:
            userNameView.removeFromSuperview()
            emailView.isHidden = false
        case .pass:
            emailView.removeFromSuperview()
            passWordView.isHidden = false
        case .information:
            infomationView.isHidden = false
        }
    }
    
    func saveInfomation() {
        Constants.sharedInstance.memberProfile?.dateOfBirth = birthDay.text
        Constants.sharedInstance.memberProfile?.sex = (sex.text == "female") ? 1 : 0
        Constants.sharedInstance.memberProfile?.job = occupation.text
        Constants.sharedInstance.memberProfile?.hobby = hobby.text
        Constants.sharedInstance.memberProfile?.marriage = statusMarrie.text
        Constants.sharedInstance.memberProfile?.name = userNameTextField.text!
        _ = UIAlertController.initAler(title: "Success", message: "Change infomation conplete", inViewController: self)
    }
    
    @IBAction func pressedShowDate(_ sender: Any) {
        if let dateDailog = SettingDatepicker.instance() as? SettingDatepicker {
            dateDailog.show()
            dateDailog.callBackDate = { [weak self] date in
                self?.birthDay.text = date
            }
        }
    }
    
    @IBAction func pressShowSex(_ sender: Any) {
        if let sexDailog = SettingChooseSex.instance() as? SettingChooseSex {
            sexDailog.show()
            sexDailog.calBack = { [weak self] sexMenber in
                self?.sex.text = sexMenber
            }
        }
    }
    
    @IBAction func pressShowMarrie(_ sender: Any) {
        if let marrieDailog = SettingStatus.instance() as? SettingStatus {
            marrieDailog.show()
            marrieDailog.callBack = { [weak self] status in
                self?.statusMarrie.text = status
            }
        }
    }
}
