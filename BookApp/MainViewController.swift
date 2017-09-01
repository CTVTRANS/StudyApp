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
    var arrayNews = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getAllNews : GetAllNewsTask = GetAllNewsTask(limit: 20, page: 1)
        showActivity(inView: self.view)
        table.estimatedRowHeight = 140
        requestWithTask(task: getAllNews, success: { (data) in
            self.arrayNews = data as! [NewsModel]
            self.table.reloadData()
            self.stopActivityIndicator()
        }) { (error) in
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        table.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainViewCell = table.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
        cell.binData(news: arrayNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let type = arrayNews[indexPath.row].typeNews
        if (type == 4) {
            let vc: Type2DetailNewsViewController = self.storyboard?.instantiateViewController(withIdentifier: "Type2Detail") as! Type2DetailNewsViewController
            vc.news = arrayNews[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc: DetailNewsController = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailNewsController
            vc.news = arrayNews[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func setupCallBack() {
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
}
