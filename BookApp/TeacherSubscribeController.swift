//
//  TeacherSubscribeController.swift
//  BookApp
//
//  Created by kien le van on 8/14/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class TeacherSubscribeController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeacherSubcribeCell = table.dequeueReusableCell(withIdentifier: "TeacherSubcribeCell", for: indexPath) as! TeacherSubcribeCell
        cell.callBack = {
            print("ok")
        }
        return cell
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
