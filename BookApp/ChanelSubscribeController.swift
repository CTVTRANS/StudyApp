//
//  TeacherSubscribeController.swift
//  BookApp
//
//  Created by kien le van on 8/14/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ChanelSubscribeController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChanelSubcribeCell = table.dequeueReusableCell(withIdentifier: "ChanelSubcribeCell", for: indexPath) as! ChanelSubcribeCell
        cell.callBack = {
            print("ok")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let detailTeacherVC: DetailChanelViewController = storyboard!.instantiateViewController(withIdentifier: "DetailChanelViewController") as! DetailChanelViewController
        self.navigationController?.pushViewController(detailTeacherVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
