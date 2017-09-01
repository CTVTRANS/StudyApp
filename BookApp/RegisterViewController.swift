//
//  RegisterViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var showAreButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "註冊"
        navigationController?.navigationBar.backItem?.title = ""
        showAreButton.layer.borderColor = UIColor.rgb(r: 255, g: 101, b: 0).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
