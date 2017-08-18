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
    @IBOutlet weak var suggestBookView: CustomBookCollection!
    @IBOutlet weak var freeBookView: CustomBookCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        suggestBookView.setupView(image: #imageLiteral(resourceName: "ic_reload"))
        freeBookView.setupView(image: #imageLiteral(resourceName: "ic_next"))
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
