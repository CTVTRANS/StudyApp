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
    var listIDGroupJoined = Set<Int>()
    
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
            self.stopActivityIndicator()
        }
        let getGroupJoined: GetGroupJoinedTask = GetGroupJoinedTask(id: 1)
        requestWithTask(task: getGroupJoined, success: { (data) in
            Constants.sharedInstance.listGroupJoined = (data as? [SecrectGroup])!
            self.loadedGroupJoined = true
            if self.loadedAllGroup && self.loadedGroupJoined {
                self.table.reloadData()
                self.stopActivityIndicator()
            }
            for group in  Constants.sharedInstance.listGroupJoined {
                self.listIDGroupJoined.insert(group.id)
            }
        }) { (error) in
            self.stopActivityIndicator()
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
        let group = arrayGroup[indexPath.row]
        if listIDGroupJoined.contains(group.id) {
            listIDGroupJoined.remove(group.id)
            for index in 0..<Constants.sharedInstance.listGroupJoined.count {
                if group.id == Constants.sharedInstance.listGroupJoined[index].id {
                    Constants.sharedInstance.listGroupJoined.remove(at: index)
                    break
                }
            }
        } else {
            listIDGroupJoined.insert(group.id)
            Constants.sharedInstance.listGroupJoined.append(group)
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func pressRightBarButton() {
        let vc: GroupJoinedViewController = storyboard?.instantiateViewController(withIdentifier: "GroupJoinedViewController") as! GroupJoinedViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func notPrettyString(from object: Any) -> String? {
        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted) {
            let objectString = String(data: objectData, encoding: .utf8)
            return objectString
        }
        return nil
    }
    
    @IBAction func pressedAddButton(_ sender: Any) {
        let arrayListIdGroup = Array(listIDGroupJoined)
        let jsonObject: String = notPrettyString(from: arrayListIdGroup)!
        print(jsonObject)
        let subcrible: SubcribleGroupTask = SubcribleGroupTask(arryID: jsonObject)
        requestWithTask(task: subcrible, success: { (data) in
            print(data!)
        }) { (error) in
            print(error!)
        }
    }
}
