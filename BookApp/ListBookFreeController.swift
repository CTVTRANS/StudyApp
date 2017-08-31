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
        let getBookFree: GetBookFree = GetBookFree(limit: 10, page: 1)
        requestWithTask(task: getBookFree, success: { (data) in
            self.listBook = data as! [Book]
            self.table.reloadData()
        }) { (error) in
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListBookFreeCell = table.dequeueReusableCell(withIdentifier: "ListBookFreeCell", for: indexPath) as! ListBookFreeCell
        cell.binData(book: listBook[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}