//
//  BookViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BookViewController: BaseViewController {

    @IBOutlet weak var navigationCustom: NavigationCustom!
    @IBOutlet weak var suggestBookView: CustomBookCollection!
    @IBOutlet weak var freeBookView: CustomBookCollection!
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
    }
    
    func setupCallBackClickCell() {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        let vc: BookDetailViewController = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as! BookDetailViewController
        suggestBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        freeBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
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
