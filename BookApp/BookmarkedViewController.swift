//
//  BookmarkedViewController.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookmarkedViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "BookDownloadCell", bundle: nil), forCellReuseIdentifier: "bookCell")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "我的收藏"
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            //            return listBookDownloaded.count
            return 3
        } else {
            //            return listChanelDownloaded.count
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell: NewsBookmarkedCell = table.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsBookmarkedCell
        let bookCell: BookDownloadCell = table.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookDownloadCell
        
        if segment.selectedSegmentIndex == 0 {
            return newsCell
        } else {
            return bookCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func pressedSegment(_ sender: Any) {
        table.reloadData()
    }
}
