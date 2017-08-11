//
//  MainViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationCustoms: NavigationCustom!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationCustoms.callBackMessageNotification = {
            print("message")
        }
        
        navigationCustoms.callBackVideoNotification = {
             print("video")
        }
        
        navigationCustoms.callBackSearchNotification = {
             print("search")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainViewCell = table.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let vc: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
