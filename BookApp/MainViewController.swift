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
    private var pager = 1
    private var isMoreData = true
    private var isLoadMore = false
    private var arrayNews: [NewsModel] = []
    lazy var footerView = UIView.initFooterView()
    private var indicator: UIActivityIndicatorView?
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.backgroundColor = UIColor.white
        refresh.tintColor = UIColor.gray
        refresh.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBack()
        showActivity(inView: self.view)
        table.estimatedRowHeight = 140
        table.addSubview(refreshControl)
        if let ac = footerView.viewWithTag(8) as? UIActivityIndicatorView {
            indicator = ac
        }
        loadMoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        table.reloadData()
    }
    
    func reloadData() {
        pager = 1
        isMoreData = true
        arrayNews.removeAll()
        loadMoreData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as? MainViewCell {
        cell.binData(news: arrayNews[indexPath.row])
        return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let type = arrayNews[indexPath.row].typeNews
        if type == 1 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailNewsController {
                vc.news = arrayNews[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if type == 2 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Type2Detail") as? Type2DetailNewsViewController {
                vc.news = arrayNews[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Type3DetailNewsController") as? Type3DetailNewsController {
                vc.news = arrayNews[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endOftable = table.contentOffset.y >= (table.contentSize.height - table.frame.size.height)
        if isMoreData && endOftable && !isLoadMore && !scrollView.isDragging && !scrollView.isDecelerating {
            isLoadMore = true
            table.tableFooterView = footerView
            indicator?.startAnimating()
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        let getAllNews: GetAllNewsTask = GetAllNewsTask(page: pager)
        requestWithTask(task: getAllNews, success: { (data) in
            if let list = data as? [NewsModel] {
                self.arrayNews += list
                self.table.reloadData()
                self.isLoadMore = false
                self.stopActivityIndicator()
                self.refreshControl.endRefreshing()
                self.indicator?.stopAnimating()
                self.pager += 1
                if list.count == 0 {
                    self.isMoreData = false
                    self.table.tableFooterView = UIView()
                }
            }
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    func setupCallBack() {
        navigationCustoms.callBackTopButton = { [weak self] (typeButton: TopButton) in
            if typeButton == TopButton.search {
                self?.goToSearch()
                return
            }
            if !(self?.checkLogin())! {
                self?.goToSigIn()
                return
            }
            switch typeButton {
            case TopButton.messageNotification:
                self?.goToNotification(myViewController: self!)
            case TopButton.videoNotification:
                self?.goToListPlayaudio()
            default :
                break
            }
        }
    }
}
