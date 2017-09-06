//
//  DetailNotificationMessageController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailNotificationMessageController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "通知列表"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全標已讀",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(deleteMessage))
    }
    
    func deleteMessage() {
        print("delete")
    }

}
