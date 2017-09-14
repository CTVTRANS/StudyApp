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
}
