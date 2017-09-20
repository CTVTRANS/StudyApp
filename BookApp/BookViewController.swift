//
//  BookViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import SDWebImage
import FSPagerView

class BookViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FSPagerViewDelegate, FSPagerViewDataSource {

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
    
    private var listSlider: [SliderShow] = []
    @IBOutlet weak var sliderShow: FSPagerView! {
        didSet {
            self.sliderShow.scrollDirection = .vertical
            self.sliderShow.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.sliderShow.itemSize = .zero
        }
    }
    @IBOutlet weak var pageControlView: FSPageControl! {
        didSet {
            self.pageControlView.transform = CGAffineTransform(rotationAngle: .pi/2)
            self.pageControlView.contentHorizontalAlignment = .center
            self.pageControlView.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTitle()
        setupCallBackClickCell()
        setupCallBackNavigation()
        showActivity(inView: self.view)
        getBaner()
        getBookNewest()
        getBookSuggest()
        getBookFree()
        getTypeBook()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setUpTitle() {
        suggestBookView.setupView(image: #imageLiteral(resourceName: "ic_reload"))
        suggestBookView.detailTitle.text = "換一換"
        suggestBookView.titleView.text = "猜你喜歡"
        freeBookView.setupView(image: #imageLiteral(resourceName: "ic_next"))
        freeBookView.detailTitle.text = "全部"
        freeBookView.titleView.text = "限時免費"
    }
    
    // MARK: Get Baner From Server
    
    func getBaner() {
        let getBanerTask = GetSliderBanerTask(typeSlider: ScreenShow.book.rawValue)
        requestWithTask(task: getBanerTask, success: { (data) in
            if let listBaner = data as? [SliderShow] {
                self.listSlider = listBaner
                self.pageControlView.numberOfPages = self.listSlider.count
                self.sliderShow.reloadData()
            }
        }) { (_) in
            
        }
    }
    
    // MARK: Get Type Book
    
    func getTypeBook() {
        let getTypeTask: GetTypeOfBookTask = GetTypeOfBookTask()
        requestWithTask(task: getTypeTask, success: { (_) in
            self.bookTypeArray = Constants.sharedInstance.listBookType
            self.tableBookType.reloadData()
            self.loadedTypeBook = true
            if self.loadedTypeBook && self.loadefBookFree && self.loadedBookSuggest {
                self.stopActivityIndicator()
            }
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: " ",
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    // MARK: Get Book Suggest
    
    func getBookSuggest() {
        let getBookSuggest: GetAllBookSuggestTask = GetAllBookSuggestTask(limit: 3, page: 1)
        requestWithTask(task: getBookSuggest, success: { (data) in
            self.suggestBookView.reloadData(arrayOfBook: (data as? [Book])!)
            self.loadedBookSuggest = true
            if self.loadedTypeBook && self.loadefBookFree && self.loadedBookSuggest {
                self.stopActivityIndicator()
            }
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    // MARK: Get Book Free
    
    func getBookFree() {
        let getBookFree: GetBookFreeTask = GetBookFreeTask(limit: 3, page: 1)
        requestWithTask(task: getBookFree, success: { (data) in
            self.freeBookView.reloadData(arrayOfBook: (data as? [Book])!)
            self.loadefBookFree = true
            if self.loadedTypeBook && self.loadefBookFree && self.loadedBookSuggest {
                self.stopActivityIndicator()
            }
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    // MARK: Get Book Newest
    
    func getBookNewest() {
        let getNewestBookTask: GetBookNewestTask = GetBookNewestTask()
        requestWithTask(task: getNewestBookTask, success: { (data) in
            self.newestBook = (data as? Book)!
            self.newestBookImage.sd_setImage(with: URL(string: self.newestBook.imageURL))
            self.newestBooktype.text = " " + self.newestBook.typeName + " "
            self.newestBookName.text = self.newestBook.name
            self.newestBookDescription.text = self.newestBook.author
            self.newestBookNumberView.text = String(self.newestBook.numberHumanReaed)
            let dateupBook = self.newestBook.timeUpBook.components(separatedBy: " ")
            self.newestBookTimeUp.text = dateupBook[0]
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    // MARK: TableView Data Souce
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tableBookType.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BookTypeViewCell
        cell?.binData(typeBook: bookTypeArray[indexPath.row])
        return cell!
    }
    
    // MARK: TableView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type: BookType = bookTypeArray[indexPath.row]
        let getBook: GetBookSuggestForTypeTask =
            GetBookSuggestForTypeTask(category: type.typeID, limit: 3)
        requestWithTask(task: getBook, success: { (data) in
            self.suggestBookView.reloadData(arrayOfBook: (data as? [Book])!)
        }) { (error) in
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    // MARK: FSPagerView Data Source
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listSlider.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = sliderShow.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string:listSlider[index].imageURL), completed: { (_, _, _, _) in
        })
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    // MARK: FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        sliderShow.deselectItem(at: index, animated: true)
        sliderShow.scrollToItem(at: index, animated: true)
        self.pageControlView.currentPage = index
        print(index)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControlView.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControlView.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
    // MARK: Call Back
    
    func setupCallBackClickCell() {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        suggestBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as? BookDetailViewController
            vc?.bookSelected = bookSelected
            self?.navigationController?.pushViewController(vc!, animated: true)
        }
        suggestBookView.callBackReloadButton = { [weak self] in
            let getBookSuggest: GetAllBookSuggestTask = GetAllBookSuggestTask(limit: 3, page: 2)
            self?.requestWithTask(task: getBookSuggest, success: { (data) in
                self?.suggestBookView.reloadData(arrayOfBook: (data as? [Book])!)
            }) { (error) in
                _ = UIAlertController(title: nil,
                                      message: error as? String,
                                      preferredStyle: .alert)
            }
        }
        
        freeBookView.callBackClickCell = {[weak self] (bookSelected: Book) in
            let vc = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as? BookDetailViewController
            vc?.bookSelected = bookSelected
            self?.navigationController?.pushViewController(vc!, animated: true)
        }
        freeBookView.callBackReloadButton = { [weak self] in
            let vc = bookStoryboard.instantiateViewController(withIdentifier: "ListBookFreeController") as? ListBookFreeController
            self?.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func pressedShowDetailBook(_ sender: Any) {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        let vc = bookStoryboard.instantiateViewController(withIdentifier: "BookDetail") as? BookDetailViewController
        vc?.bookSelected = newestBook
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setupCallBackNavigation() {
        navigationCustom.callBackTopButton = { [weak self] (typeButton: TopButton) in
            let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
            switch typeButton {
            case TopButton.messageNotification:
                let vc = myStoryboard.instantiateViewController(withIdentifier: "NotificationMessageViewController") as? UINavigationController
                self?.present(vc!, animated: true, completion: nil)
            case TopButton.videoNotification:
                let vc = myStoryboard.instantiateViewController(withIdentifier: "NotificationVideoViewController") as? UINavigationController
                self?.present(vc!, animated: true, completion: nil)
            case TopButton.search:
                let vc = myStoryboard.instantiateViewController(withIdentifier: "Search") as? UINavigationController
                self?.present(vc!, animated: true, completion: nil)
            }
        }
    }
}
