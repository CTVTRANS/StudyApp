//
//  SearchViewController.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var typeView: CustomHistorySearch!
    @IBOutlet weak var heightOfTypeView: NSLayoutConstraint!
    @IBOutlet weak var hotView: CustomHistorySearch!
    @IBOutlet weak var heightOfHotView: NSLayoutConstraint!
    
    private var listBook: [Book] = []
    private var listTypeBook: [String] = []
    private var loadedTypeBook = false
    
    private var listNew: [NewsModel] = []
    private var listTypeNews: [String] = []
    private var loadedTypeNews = false
    private var seachBook: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.isHidden = true
        table.tableFooterView = UIView()
        searchBar.backgroundImage = UIImage()
        setUp()
        setUPCallBack()
    }
    
    private func setUp() {
        typeView.title.text = "types"
        let getAllTypeNews: GetAllTypeNewsTask = GetAllTypeNewsTask()
        requestWithTask(task: getAllTypeNews, success: { (_) in
            self.loadedTypeNews = true
            for typeNews in Constants.sharedInstance.listNewsType {
                self.listTypeNews.append(typeNews.nameType)
            }
            if self.loadedTypeBook && self.loadedTypeNews {
                self.showTypeAndHotKeyWord()
            }
        }) { (_) in
            
        }
        
        let getAllTypeBook: GetTypeOfBookTask = GetTypeOfBookTask()
        requestWithTask(task: getAllTypeBook, success: { (_) in
            self.loadedTypeBook = true
            for typeBook in Constants.sharedInstance.listBookType {
                self.listTypeBook.append(typeBook.name)
            }
            if self.loadedTypeBook && self.loadedTypeNews {
                self.showTypeAndHotKeyWord()
            }
        }) { (_) in
            
        }
    }
    
    func setUPCallBack() {
        typeView.callBackButton = { (_ name: String) in
            print(name)
        }
        hotView.callBackButton = { (_ name: String) in
            print(name)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seachBook {
            return listBook.count
        }
        return listNew.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ResultSearch
        if seachBook {
            cell?.binData(objec: listBook[indexPath.row])
        } else {
            cell?.binData(objec: listNew[indexPath.row])
        }
        return cell!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    @IBAction func pressedCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            table.isHidden = true
        }
    }
    
    @IBAction func pressedChangeType(_ sender: Any) {
        if seachBook {
            seachBook = false
        } else {
            seachBook = true
        }
        showTypeAndHotKeyWord()
        listBook.removeAll()
        listNew.removeAll()
        table.reloadData()
        table.isHidden = true
    }
    
    private func showTypeAndHotKeyWord() {
        if seachBook {
            typeView.listText = listTypeBook
        } else {
            typeView.listText = listTypeNews
        }
        typeView.realoadData()
    }
    
    func searchAction() {
        
    }
}
