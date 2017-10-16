//
//  SplashViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import SWRevealViewController

class SplashViewController: BaseViewController {

    @IBOutlet weak var traditionalButton: UIButton!
    @IBOutlet weak var simpleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        traditionalButton.layer.borderColor = UIColor.rgb(113, 112, 110).cgColor
        simpleButton.layer.borderColor = UIColor.rgb(113, 112, 110).cgColor
        
        let getDefault = GetDefaultSettingTask()
        requestWithTask(task: getDefault, success: { (_) in
            
        }) { (_) in
            
        }
    }
    
    @IBAction func pressedTraditionnal(_ sender: Any) {
        let getDefault = GetDefaultSettingTask()
        requestWithTask(task: getDefault, success: { (_) in
            
        }) { (_) in
            
        }
        
        let sendToken = SendTokenTask()
        requestWithTask(task: sendToken, success: { (_) in
            
        }) { (_) in
            
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            Constants.sharedInstance.language = 1
            self.present(vc, animated: false, completion: nil)
        }
    }

    @IBAction func pressSimple(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            Constants.sharedInstance.language = 0
            self.present(vc, animated: false, completion: nil)
        }

    }
}
