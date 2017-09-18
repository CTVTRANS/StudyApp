//
//  ActivityOfflineViewController.swift
//  BookApp
//
//  Created by kien le van on 9/8/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ActivityOfflineViewController: BaseViewController {

    @IBOutlet weak var addGroupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGroupButton.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
        navigationItem.title = "線下活動"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分會圈子",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(pressRighBarButton))
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func pressRighBarButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GroupJoinedViewController") as? GroupJoinedViewController
        navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func pressedAddGroupButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowAllActivityGroupController") as? ShowAllActivityGroupController
        navigationController?.pushViewController(vc!, animated: true)
    }
}
