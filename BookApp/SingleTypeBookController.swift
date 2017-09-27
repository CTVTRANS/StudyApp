//
//  SingleTypeBookController.swift
//  BookApp
//
//  Created by kien le van on 9/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class SingleTypeBookController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var typeBook: BookType?
    private var listBook: [Book] = []
    lazy var footerView = UIView.initFooterView()
    private var indicator: UIActivityIndicatorView?
    var isMoreData = true
    var isLoading = false
    var pager = 1
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivity(inView: self.view)
        table.register(UINib.init(nibName: "ListBookFreee", bundle: nil), forCellReuseIdentifier: "cell")
        table.estimatedRowHeight = 140
        if let ac = footerView.viewWithTag(8) as? UIActivityIndicatorView {
            indicator = ac
        }
        loadMoreData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endOftable = table.contentOffset.y >= (table.contentSize.height - table.frame.size.height)
        if isMoreData && endOftable && !isLoading && !scrollView.isDragging && !scrollView.isDecelerating {
            isLoading = true
            table.tableFooterView = footerView
            indicator?.startAnimating()
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListBookFreee
        cell?.binData(book: listBook[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BookDetail") as? BookDetailViewController {
            vc.bookSelected = listBook[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadMoreData() {
        let getBook: GetListBookForTypeTask = GetListBookForTypeTask(category: (typeBook?.typeID)!, page: pager)
        requestWithTask(task: getBook, success: { (data) in
            if let arrayBook = data as? [Book] {
                self.listBook += arrayBook
                self.stopActivityIndicator()
                self.indicator?.stopAnimating()
                self.isLoading = false
                self.table.reloadData()
                self.pager += 1
                if arrayBook.count == 0 {
                    self.isMoreData = false
                    self.table.tableFooterView = UIView()
                }
            }
        }) { (error) in
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }

    }
}
