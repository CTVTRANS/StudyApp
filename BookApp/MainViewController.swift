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
        setupCallBack()
        
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
        if (type == 1) {
            let vc: DetailNewsController = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailNewsController
            vc.news = arrayNews[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        } else if type == 2 {
            let vc: Type2DetailNewsViewController = storyboard?.instantiateViewController(withIdentifier: "Type2Detail") as! Type2DetailNewsViewController
            vc.news = arrayNews[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc: Type3DetailNewsController = storyboard?.instantiateViewController(withIdentifier: "Type3DetailNewsController") as! Type3DetailNewsController
            vc.news = arrayNews[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func setupCallBack() {
        navigationCustoms.callBackTopButton = { [weak self] (typeButton: TopButton) in
            let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
            switch typeButton {
            case TopButton.messageNotification:
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationMessageViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.videoNotification:
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationVideoViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.search:
                let vc: SearchViewController = myStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
                 self?.present(vc, animated: true, completion: nil)
            }
        }
    }
}
