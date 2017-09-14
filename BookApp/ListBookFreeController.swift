//
//  ListBookFreeController.swift
//  BookApp
//
//  Created by kien le van on 8/31/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ListBookFreeController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var listBook = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "BookFree"
        table.estimatedRowHeight = 140
        table.register(UINib.init(nibName: "ListBookFreee", bundle: nil), forCellReuseIdentifier: "cell")
        let getBookFree: GetBookFree = GetBookFree(limit: 10, page: 1)
        showActivity(inView: UIApplication.shared.keyWindow!)
        requestWithTask(task: getBookFree, success: { (data) in
            self.listBook = data as! [Book]
            self.table.reloadData()
            self.stopActivityIndicator()
        }) { (error) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListBookFreee = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListBookFreee
        cell.binData(book: listBook[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
        vc.bookSelected = listBook[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
