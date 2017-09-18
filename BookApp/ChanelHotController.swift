//
//  ChanelHotController.swift
//  BookApp
//
//  Created by kien le van on 9/6/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ChanelHotController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var listChanelHot = [Chanel]()
    let listChanelSubcribled = Constants.sharedInstance.listChanelSubcribled
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "ChanelViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        let getHotChanel: GetHotChanelTask = GetHotChanelTask(lang: Constants.sharedInstance.language, limit: 20, page: 1)
        requestWithTask(task: getHotChanel, success: { (data) in
            self.listChanelHot = (data as? [Chanel])!
            self.table.reloadData()
        }) { (error) in
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listChanelHot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChanelViewCell
        let chanel = listChanelHot[indexPath.row]
        cell?.binData(chanel: chanel)
        for chanelHot in Constants.sharedInstance.listChanelSubcribled {
            if chanel.idChanel ==  chanelHot.idChanel {
                cell?.subcribleButton.setTitle("  已訂閱頻道  ", for: .normal)
                cell?.subcribleButton.isEnabled = false
                break
            } else {
                 cell?.subcribleButton.setTitle("  訂閱頻道  ", for: .normal)
            }
        }
        cell?.callBackButton = { [weak self] in
            let subcrible: SubcribleChanelTask =
                SubcribleChanelTask(memberID: 1,
                                    chanelID: chanel.idChanel)
            self?.requestWithTask(task: subcrible, success: { (data) in
                let status: Subcrible = (data as? Subcrible)!
                if status == Subcrible.subcrible {
                    Constants.sharedInstance.listChanelSubcribled.append(chanel)
                    cell?.subcribleButton.setTitle("  已訂閱頻道  ", for: .normal)
                    cell?.subcribleButton.isEnabled = false
                }
            }) { (error) in
                _ = UIAlertController(title: nil,
                                      message: error as? String,
                                      preferredStyle: .alert)
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let detailTeacherVC = storyboard!.instantiateViewController(withIdentifier: "DetailChanelViewController") as? DetailChanelViewController
        detailTeacherVC?.chanel = listChanelHot[indexPath.row]
        self.navigationController?.pushViewController(detailTeacherVC!, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
