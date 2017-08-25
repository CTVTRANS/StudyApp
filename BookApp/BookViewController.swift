//
//  BookViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var navigationCustom: NavigationCustom!
    @IBOutlet weak var tableBookType: UICollectionView!
    
    @IBOutlet weak var suggestBookView: CustomBookCollection!
    @IBOutlet weak var freeBookView: CustomBookCollection!
    var bookTypeArray = [String]()
    var suggestArray = [Book]()
    var freeArray = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBackClickCell()

        suggestBookView.setupView(image: #imageLiteral(resourceName: "ic_reload"))
        freeBookView.setupView(image: #imageLiteral(resourceName: "ic_next"))
        
        let book1: Book = Book(name: "toic 0", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2")
        let book2: Book = Book(name: "toic 1", imageUrl: "abc", numberReaded: "63", timeUp: "2017/7/2")
        let book3: Book = Book(name: "toic 2", imageUrl: "abc", numberReaded: "39", timeUp: "2017/8/2")
        suggestArray.append(book1)
        suggestArray.append(book2)
        suggestArray.append(book3)
        suggestBookView.bookArray = suggestArray
        
        let book4: Book = Book(name: "toic 3", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2")
        let book5: Book = Book(name: "toic 4", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2")
        let book6: Book = Book(name: "toic 5", imageUrl: "abc", numberReaded: "13", timeUp: "2017/6/2")
        freeArray.append(book4)
        freeArray.append(book5)
        freeArray.append(book6)
        freeBookView.bookArray = freeArray
        bookTypeArray = ["co dien", "hien dai", "chien tranh", "tinh yeu", "tho", "truyen ngan"]
    }
    
    func setupCallBackClickCell() {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        suggestBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        freeBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func pressedShowDetailBook(_ sender: Any) {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        let vc: BookAudioController = bookStoryboard.instantiateViewController(withIdentifier: "BookAudio") as! BookAudioController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookTypeViewCell = tableBookType.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookTypeViewCell
        cell.binData(typeBook: bookTypeArray[indexPath.row])
        return cell
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
