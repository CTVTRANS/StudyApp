//
//  BookViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import SDWebImage

class BookViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var navigationCustom: NavigationCustom!
    @IBOutlet weak var tableBookType: UICollectionView!
    @IBOutlet weak var suggestBookView: CustomBookCollection!
    @IBOutlet weak var freeBookView: CustomBookCollection!
    @IBOutlet weak var newestBookImage: UIImageView!
    @IBOutlet weak var newestBooktype: UILabel!
    @IBOutlet weak var newestBookName: UILabel!
    @IBOutlet weak var newestBookDescription: UILabel!
    @IBOutlet weak var newestBookTimeUp: UILabel!
    @IBOutlet weak var newestBookNumberView: UILabel!
    
    private var bookTypeArray = [BookType]()
    private var suggestArray = [Book]()
    private var freeArray = [Book]()
    private var  newestBook: Book!
    private var loadedTypeBook: Bool = false
    private var loadedBookSuggest: Bool = false
    private var loadefBookFree: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBackClickCell()
        suggestBookView.setupView(image: #imageLiteral(resourceName: "ic_reload"))
        suggestBookView.detailTitle.text = "換一換"
        suggestBookView.titleView.text = "近期新書"
        freeBookView.setupView(image: #imageLiteral(resourceName: "ic_next"))
        freeBookView.detailTitle.text = "全部"
        freeBookView.titleView.text = "猜你喜歡"
        
        let getTypeTask: GetTypeOfBookTask = GetTypeOfBookTask()
        showActivity(inView: self.view)
        requestWithTask(task: getTypeTask, success: { (data) in
            self.bookTypeArray = Constants.sharedInstance.listBookType!
            self.tableBookType.reloadData()
            self.loadedTypeBook = true
            if (self.loadedTypeBook && self.loadefBookFree && self.loadedBookSuggest) {
                 self.stopActivityIndicator()
            }
        }) { (error) in
            
        }
        
        let getNewestBookTask: GetBookNewestTask = GetBookNewestTask()
        requestWithTask(task: getNewestBookTask, success: { (data) in
            self.newestBook = data as! Book
            self.newestBookImage.sd_setImage(with: URL(string: self.newestBook.imageURL))
            self.newestBooktype.text = " " + self.newestBook.typeName + " "
            self.newestBookName.text = self.newestBook.name
            self.newestBookDescription.text = self.newestBook.author
            self.newestBookNumberView.text = String(self.newestBook.numberHumanReaed)
            let dateupBook = self.newestBook.timeUpBook.components(separatedBy: " ")
            self.newestBookTimeUp.text = dateupBook[0]
        }) { (error) in
            
        }
        
        let getBookSuggest: GetAllBookSuggest = GetAllBookSuggest(limit: 3, page: 1)
        requestWithTask(task: getBookSuggest, success: { (data) in
            self.suggestBookView.reloadData(arrayOfBook: data as! [Book])
            self.loadedBookSuggest = true
            if (self.loadedTypeBook && self.loadefBookFree && self.loadedBookSuggest) {
                self.stopActivityIndicator()
            }
        }) { (error) in
            
        }
        
        let getBookFree: GetBookFree = GetBookFree(limit: 3, page: 1)
        requestWithTask(task: getBookFree, success: { (data) in
            self.freeBookView.reloadData(arrayOfBook: data as! [Book])
            self.loadefBookFree = true
            if (self.loadedTypeBook && self.loadefBookFree && self.loadedBookSuggest) {
                self.stopActivityIndicator()
            }
        }) { (error) in
            
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookTypeViewCell = tableBookType.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookTypeViewCell
        cell.binData(typeBook: bookTypeArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type: BookType = bookTypeArray[indexPath.row]
        let getBook: GetBookSuggestForType = GetBookSuggestForType(category: type.typeID, limit: 3)
        requestWithTask(task: getBook, success: { (data) in
            self.suggestBookView.reloadData(arrayOfBook: data as! [Book])
        }) { (error) in

        }
        
//        let getBook: GetListBookForTypeTask  = GetListBookForTypeTask(category: type.typeID, page: "1")
//        requestWithTask(task: getBook, success: { (data) in
//            self.suggestBookView.reloadData(arrayOfBook: data as! [Book])
//        }) { (error) in
//            
//        }
    }
    
    func setupCallBackClickCell() {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        suggestBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
            vc.bookSelected = bookSelected
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        suggestBookView.callBackReloadButton = { [weak self] in
//            self?.showActivity(with: "loading...", inView: (self?.suggestBookView)!)
            let getBookSuggest: GetAllBookSuggest = GetAllBookSuggest(limit: 3, page: 2)
            self?.requestWithTask(task: getBookSuggest, success: { (data) in
                self?.suggestBookView.reloadData(arrayOfBook: data as! [Book])
//                self?.stopActivityIndicator()
            }) { (error) in
                
            }
        }
        
        freeBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
            vc.bookSelected = bookSelected
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        freeBookView.callBackReloadButton = { [weak self] in
            let vc: ListBookFreeController = bookStoryboard.instantiateViewController(withIdentifier: "ListBookFreeController") as! ListBookFreeController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func pressedShowDetailBook(_ sender: Any) {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
        vc.bookSelected = newestBook
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupCallBackNavigation() {
        navigationCustom.callBackMessageNotification = {
            
        }
        navigationCustom.callBackVideoNotification = {
            
        }
        navigationCustom.callBackSearchNotification = {
            
        }
    }
}
