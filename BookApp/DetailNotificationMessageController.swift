//
//  DetailNotificationMessageController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailNotificationMessageController: BaseViewController {

    @IBOutlet weak var detal: UILabel!
    var objectiNotification: NotificationApp?
    var indexobjec: Int?
    var callBack = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "通知列表"
        detal.text = objectiNotification?.detailText
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全標已讀",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(deleteMessage))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func deleteMessage() {
        self.callBack()
        navigationController?.popViewController(animated: true)
    }

}
