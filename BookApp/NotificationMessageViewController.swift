//
//  NotificationMessageViewController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NotificationMessageViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    private var listNotification: [NotificationApp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getData() {
        let getData = GetNotificationTask(limit: 100, page: 1, memberID: (memberInstance?.idMember)!)
        requestWithTask(task: getData, success: { (data) in
            if let array = data as? [NotificationApp] {
                self.listNotification = array
                self.table.reloadData()
            }
        }) { (_) in
            
        }
    }
    
    // MARK: Table Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "MessageNotificationCell", for: indexPath) as? MessageNotificationCell {
            cell.binData(objectNotification: listNotification[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: Table Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailNotificationMessageController") as? DetailNotificationMessageController {
            vc.objectiNotification = listNotification[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func pressedReadAllMessage(_ sender: Any) {
        listNotification.removeAll()
        table.reloadData()
    }
    
    @IBAction func pressedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
