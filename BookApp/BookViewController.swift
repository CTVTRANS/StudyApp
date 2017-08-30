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
        setupCallBackClickCell()
        suggestBookView.setupView(image: #imageLiteral(resourceName: "ic_reload"))
        freeBookView.setupView(image: #imageLiteral(resourceName: "ic_next"))
        
        let getTypeTask: GetTypeOfBookTask = GetTypeOfBookTask()
        showActivity(withName: "loading...")
        requestWithTask(task: getTypeTask, success: { (data) in
            self.bookTypeArray = Constants.sharedInstance.listBookType!
            self.tableBookType.reloadData()
            self.stopActivityIndicator()
        }) { (error) in
            
        }
        
       
        let getNewestBookTask: GetBookNewestTask = GetBookNewestTask()
        requestWithTask(task: getNewestBookTask, success: { (data) in
            self.newestBook = data as! Book
            self.newestBookImage.sd_setImage(with: URL(string: self.newestBook.imageURL))
            self.newestBookName.text = self.newestBook.name
            self.newestBookauthorName.text = self.newestBook.author
            self.newestBookDescription.text = self.newestBook.description
            self.newestBookNumberView.text = String(self.newestBook.numberHumanReaed)
            self.newestBookTimeUp.text = self.newestBook.timeUpBook
        }) { (error) in
            
        }
        
        let getBookSuggest: GetAllBookSuggest = GetAllBookSuggest()
        requestWithTask(task: getBookSuggest, success: { (data) in
            self.suggestBookView.reloadData(arrayOfBook: data as! [Book])
        }) { (error) in
            
        }
        
        let getBookFree: GetBookFree = GetBookFree()
        requestWithTask(task: getBookFree, success: { (data) in
            self.freeBookView.reloadData(arrayOfBook: data as! [Book])
        }) { (error) in
            
        }

//        suggestBookView.bookArray = suggestArray
//        freeBookView.bookArray = suggestArray
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
