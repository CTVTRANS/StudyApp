//
//  SiginViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var showAreCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.title = ""
        showAreCodeButton.layer.borderColor = UIColor.rgb(255, 101, 0).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func pressedDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func pressLoginButton(_ sender: Any) {
      
    }
    
    @IBAction func pressedPhoneCountryCode(_ sender: Any) {

    }
}
