//
//  DetailTeacherViewController.swift
//  BookApp
//
//  Created by kien le van on 8/14/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailTeacherViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var nameTeacher: UILabel!
    var teacher: Teacher?
    
    @IBOutlet weak var downloadAllButton: UIButton!
    @IBOutlet weak var subcribedTeacher: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadAllButton.layer.borderColor = UIColor.rgb(r: 245, g: 166, b: 35).cgColor
        subcribedTeacher.layer.borderColor = UIColor.rgb(r: 245, g: 166, b: 35).cgColor
        table.tableFooterView = UIView()
        nameTeacher.text = teacher?.name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeacherUpLoaeCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeacherUpLoaeCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func pressedSubcribeButton(_ sender: Any) {
        
    }
    
    @IBAction func pressedDownloadAll(_ sender: Any) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
