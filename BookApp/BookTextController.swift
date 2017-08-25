//
//  BookTextController.swift
//  BookApp
//
//  Created by kien le van on 8/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookTextController: BaseViewController {
    
    @IBOutlet weak var webview: UIWebView!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
