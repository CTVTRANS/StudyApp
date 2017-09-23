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
    @IBOutlet weak var titleForViewTypes: UILabel!
    @IBOutlet weak var titleForViewHot: UILabel!
    @IBOutlet weak var heightOfTypeView: NSLayoutConstraint!
    @IBOutlet weak var hotView: CustomHistorySearch!
    @IBOutlet weak var heightOfHotView: NSLayoutConstraint!
    
    @IBOutlet weak var iconSearchBook: UILabel!
    private var listBook: [Book] = []
    private var listTypeBook: [String] = []
    private var loadedTypeBook = false
    
    @IBOutlet weak var iconSearchNews: UILabel!
    private var listNews: [NewsModel] = []
    private var listTypeNews: [String] = []
    private var loadedTypeNews = false
    private var seachBook: Bool = true
    
    private var listHot: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.isHidden = true
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 140
        searchBar.backgroundImage = UIImage()
        setUp()
        setUPCallBack()
        showTypeAndHotKeyWord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUp() {
        titleForViewTypes.text = "分類搜索"
        titleForViewHot.text = " "
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
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ResultSearch
        if seachBook {
            cell?.binData(objec: listBook[indexPath.row])
        } else {
            cell?.binData(objec: listNews[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if seachBook {
            let myStoryboard = UIStoryboard(name: "Book", bundle: nil)
            if let vc = myStoryboard.instantiateViewController(withIdentifier: "BookDetail") as? BookDetailViewController {
                vc.bookSelected = listBook[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let type = listNews[indexPath.row].typeNews
            if type == 1 {
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "Detail") as? DetailNewsController {
                    vc.news = listNews[indexPath.row]
                    navigationController?.pushViewController(vc, animated: true)
                }
            } else if type == 2 {
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "Type2Detail") as? Type2DetailNewsViewController {
                    vc.news = listNews[indexPath.row]
                    navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "Type3DetailNewsController") as? Type3DetailNewsController {
                    vc.news = listNews[indexPath.row]
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        listNews.removeAll()
        listBook.removeAll()
        if seachBook && searchBar.text != nil {
            let searchBookTask: SearchBookTask = SearchBookTask(keyWord: searchBar.text!, limit: 10, page: 1)
            requestWithTask(task: searchBookTask, success: { (data) in
                if let arrayBook =  data as? [Book] {
                    self.listBook = arrayBook
                    self.table.isHidden = false
                    self.table.reloadData()
                }
            }, failure: { (_) in
                
            })
        } else if !seachBook && searchBar.text != nil {
            let searchNewsTask: SearchNewsTask = SearchNewsTask(keyWord: searchBar.text!, limit: 10, page: 1)
            requestWithTask(task: searchNewsTask, success: { (data) in
                if let arrayNews = data as? [NewsModel] {
                    self.listNews = arrayNews
                    self.table.isHidden = false
                    self.table.reloadData()
                }
            }, failure: { (_) in
                
            })
        }
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
        searchBar.text = ""
        if seachBook {
            iconSearchBook.textColor = UIColor.black
            iconSearchNews.textColor = UIColor.rgb(red: 255, green: 102, blue: 0)
            seachBook = false
        } else {
            iconSearchBook.textColor = UIColor.rgb(red: 255, green: 102, blue: 0)
            iconSearchNews.textColor = UIColor.black
            seachBook = true
        }
        showTypeAndHotKeyWord()
    }
    
    private func showTypeAndHotKeyWord() {
        if seachBook {
            typeView.listText = listTypeBook
        } else {
            typeView.listText = listTypeNews
        }
        typeView.realoadData()
        hotView.listText = listHot
        hotView.realoadData()
        heightOfTypeView.constant = typeView.heightForView!
        listBook.removeAll()
        listNews.removeAll()
        table.isHidden = true
    }
    
    func searchAction() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
