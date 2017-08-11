//
//  DetailViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var bottomView: BottomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.pressBackButton = {
            self.navigationController?.popViewController(animated: true)
        }
    }

}
