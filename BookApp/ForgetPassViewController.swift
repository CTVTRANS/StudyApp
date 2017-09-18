//
//  ForgetPassViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ForgetPassViewController: BaseViewController {

    @IBOutlet weak var showAreButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "忘記密碼"
        showAreButton.layer.borderColor = UIColor.rgb(red: 255, green: 101, blue: 0).cgColor
    }
}
