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
    @IBOutlet weak var newestBookName: UILabel!
    @IBOutlet weak var newestBookauthorName: UILabel!
    @IBOutlet weak var newestBookDescription: UILabel!
    @IBOutlet weak var newestBookTimeUp: UILabel!
    @IBOutlet weak var newestBookNumberView: UILabel!
    var bookTypeArray = [BookType]()
    var suggestArray = [Book]()
    var freeArray = [Book]()
    var  newestBook: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getTypeTask: GetTypeOfBookTask = GetTypeOfBookTask()
        requestWithTask(task: getTypeTask, success: { (data) in
            self.bookTypeArray = Constants.sharedInstance.listBookType!
            self.tableBookType.reloadData()
        }) { (error) in
            
        }
        
        let getBookSuggest: GetAllBookSuggest = GetAllBookSuggest()
        requestWithTask(task: getBookSuggest, success: { (data) in
            self.suggestBookView.reloadData(arrayOfBook: data as! [Book])
        }) { (error) in
            
        }
        
        let getNewestBookTask: GetBookNewestTask = GetBookNewestTask()
        requestWithTask(task: getNewestBookTask, success: { (data) in
            self.newestBook = data as! Book
            self.newestBookImage.sd_setImage(with: URL(string: self.newestBook.imageURL))
            self.newestBookName.text = self.newestBook.name
            self.newestBookauthorName.text = self.newestBook.author
            self.newestBookDescription.text = self.newestBook.description
            self.newestBookNumberView.text = self.newestBook.numberHumanReaed
            self.newestBookTimeUp.text = self.newestBook.timeUpBook
        }) { (error) in
            
        }
        setupCallBackClickCell()
        suggestBookView.setupView(image: #imageLiteral(resourceName: "ic_reload"))
        freeBookView.setupView(image: #imageLiteral(resourceName: "ic_next"))
        
        let book1: Book = Book(name: "toic 0", author: "123", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2", audio: "", id: 999)
        let book2: Book = Book(name: "toic 1", author: "123", imageUrl: "abc", numberReaded: "63", timeUp: "2017/7/2", audio: "", id: 999)
        let book3: Book = Book(name: "toic 2", author: "123", imageUrl: "abc", numberReaded: "39", timeUp: "2017/8/2", audio: "", id: 999)
        suggestArray.append(book1)
        suggestArray.append(book2)
        suggestArray.append(book3)
        suggestBookView.bookArray = suggestArray
        
        let book4: Book = Book(name: "toic 3", author: "123", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2", audio: "", id: 999)
        let book5: Book = Book(name: "toic 4", author: "123", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2", audio: "", id: 999)
        let book6: Book = Book(name: "toic 5", author: "123", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2", audio: "", id: 999)
        freeArray.append(book4)
        freeArray.append(book5)
        freeArray.append(book6)
        freeBookView.bookArray = freeArray
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
//        let type: BookType = bookTypeArray[indexPath.row]
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
        freeBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
            vc.bookSelected = bookSelected
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
