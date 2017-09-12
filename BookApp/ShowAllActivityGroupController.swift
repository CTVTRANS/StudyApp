//
//  ShowAllActivityGroupController.swift
//  BookApp
//
//  Created by kien le van on 9/8/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ShowAllActivityGroupController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var table: UITableView!
    var arrayGroup = [SecrectGroup]()
    var loadedAllGroup = false
    var loadedGroupJoined = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        getData()
        table.estimatedRowHeight = 140
        table.tableFooterView = UIView()
        navigationItem.title = "分會關注"
        let backItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = backItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分會圈子", style: .done, target: self, action: #selector(pressRightBarButton))
        addButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    func getData() {
        let getAllGroup: GetAllGroupTask = GetAllGroupTask()
        requestWithTask(task: getAllGroup, success: { (data) in
            self.arrayGroup = (data as? [SecrectGroup])!
            self.loadedAllGroup = true
            if self.loadedAllGroup && self.loadedGroupJoined {
                self.table.reloadData()
                self.stopActivityIndicator()
            }
            
        }) { (eoor) in
            
        }
        let getGroupJoined: GetGroupJoinedTask = GetGroupJoinedTask(id: 1)
        requestWithTask(task: getGroupJoined, success: { (data) in
            Constants.sharedInstance.listGroupJoined = data as? [SecrectGroup]
            self.loadedGroupJoined = true
            if self.loadedAllGroup && self.loadedGroupJoined {
                self.table.reloadData()
                self.stopActivityIndicator()
            }
        }) { (error) in
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActivityGroupCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ActivityGroupCell
        cell.binData(group: arrayGroup[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func pressRightBarButton() {
        let vc: GroupJoinedViewController = storyboard?.instantiateViewController(withIdentifier: "GroupJoinedViewController") as! GroupJoinedViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func pressedAddButton(_ sender: Any) {
        
    }
}
