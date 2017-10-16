//
//  VipDetailViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class VipDetailViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var timeLimit: UILabel!
    @IBOutlet weak var statusVip: UILabel!
    @IBOutlet weak var nameMember: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "會員狀態"
        getVip()
        nameMember.text = memberInstance?.name
        if memberInstance?.level == 0 {
            statusVip.text = "NO VIP"
            timeLimit.text = ""
        } else {
            statusVip.text = "VIP"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func getVip() {
        let getProductVip: GetProductVipTask = GetProductVipTask()
        requestWithTask(task: getProductVip, success: { (data) in
            if let arrayVip = data as? [Vip] {
                self.webView.loadHTMLString( css + (arrayVip.first?.conten)!, baseURL: nil)
            }
        }, failure: { (_) in
            
        })
    }
    @IBAction func pressBuyVip(_ sender: Any) {
    }
}
