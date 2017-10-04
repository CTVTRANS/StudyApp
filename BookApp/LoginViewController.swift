//
//  SiginViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var showAreCodeButton: UIButton!
    
    private var country: Int!
    private var phone: Int!
    private var pass: String!
    private let arrayCountry: [String] = ["南韓 82", "日本 81", "台灣 886", "香港 852",
                                          "澳門 853", "中國大陸 86", "泰國 66", "馬來西亞 60",
                                          "新加坡 65", "菲律賓 63", "印尼 62", "越南 84", "印度 91",
                                          "澳洲 61", "紐西蘭 64", "帛琉 680", "大溪地 689", "美國 1",
                                          "夏威夷 1", "關島 1671", "加拿大 1", "巴拿馬 507", "阿根廷 54",
                                          "巴西 55", "英國 44", "法國 33", "義大利 39", "西班牙 34",
                                          "葡萄牙 351", "希臘 30", "瑞典 46", "奧地利 43", "德國 49",
                                          "荷蘭 31", "挪威 47", "俄羅斯 7", "南非共合國 27", "埃及 20",
                                          "摩洛哥 212", "模里西斯 230", "肯亞 254"
                                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.title = ""
        showAreCodeButton.layer.borderColor = UIColor.rgb(255, 101, 0).cgColor
        phoneNumber.delegate = self
        phoneNumber.keyboardType = .numberPad
        passWord.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func checkPhonePass() -> (Bool, String) {
        phone = Int(phoneNumber.text!)
        pass = passWord.text
        country = Int(countryCode.text!)
        if phone == nil || pass == nil {
            return (false, "phone or pass cant not emty")
        }
        if (pass?.characters.count)! < 8 {
            return (false, "pass need longer 8 character")
        }
        return (true, "success")
    }

    @IBAction func pressedDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func pressLoginButton(_ sender: Any) {
        let status = checkPhonePass()
        if !status.0 {
            _ = UIAlertController.initAler(title: " ", message: status.1, inViewController: self)
        }
        self.view.endEditing(true)
        if status.0 {
            let sigIn = SignInTaks(countryCode: country, phoneNumerber: phone, password: pass)
            requestWithTask(task: sigIn, success: { (data) in
                if let status = data as? (Bool, String) {
                    if !status.0 {
                        _ = UIAlertController.initAler(title: "", message: status.1, inViewController: self)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }, failure: { (_) in
                
            })
        }
    }
    
    @IBAction func pressedPhoneCountryCode(_ sender: Any) {
        let country = ListCountryView.instance() as? ListCountryView
        country?.callBack = { [weak self] code in
            self?.countryCode.text = "+" + code
        }
        country?.show()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
