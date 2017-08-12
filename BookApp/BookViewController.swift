//
//  BookViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookViewController: BaseViewController {

    @IBOutlet weak var navigationCustom: NavigationCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupCallBackButton() {
        navigationCustom.callBackMessageNotification = {
            
        }
        
        navigationCustom.callBackVideoNotification = {
            
        }
        
        navigationCustom.callBackSearchNotification = {
            
        }
    }


}
