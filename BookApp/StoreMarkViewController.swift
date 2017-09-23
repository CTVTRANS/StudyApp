//
//  MarkViewController.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class StoreMarkViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    private var listSlieShow: [SliderShow] = []
    private var listProduct: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "積分商城"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        collection.register(UINib.init(nibName: "StoreMarkViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        getBaner()
        getProduct()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func getBaner() {
        let getBanerTask = GetSliderBanerTask(typeSlider: ScreenShow.buyProduct.rawValue)
        requestWithTask(task: getBanerTask, success: { (data) in
            if let listBaner = data as? [SliderShow] {
                self.listSlieShow = listBaner
                self.collection.reloadData()
            }
        }) { (_) in
            
        }
    }
    
    func getProduct() {
        let getAllproduct: GetAllproductTask = GetAllproductTask(limit: 10, page: 1)
        let getProductVip: GetProductVipTask = GetProductVipTask()
        requestWithTask(task: getProductVip, success: { (data) in
            if let arrayVip = data as? [Vip] {
                self.listProduct = arrayVip
                self.getProductBookWith(task: getAllproduct)
            }
        }, failure: { (_) in
            
        })
    }

    func getProductBookWith(task: BaseTaskNetwork) {
        requestWithTask(task: task, success: { (data) in
            if let list = data as? [Book] {
                for book in list {
                    self.listProduct.append(book)
                }
                self.collection.reloadData()
            }
        }, failure: { (error) in
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        })
    }

    // MARK: Collection Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StoreMarkViewCell {
            cell.binData(product: listProduct[indexPath.row], type: TypeProductRequest.all)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (widthScreen - 10) / 2
        return CGSize(width: widthCell, height: widthCell + 20.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            if let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView {
                header.binData(listBaner: listSlieShow)
                return header
            }
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
    
    // MARK: Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as? BuyProductViewController {
            vc.product = listProduct[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressedShowAllButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as? DetailStoreMarkController {
            vc.typeRequest = TypeProductRequest.all
            vc.navigationTitle = "所有商品"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func pressedShowMarkButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as? DetailStoreMarkController {
            vc.typeRequest = TypeProductRequest.point
            vc.navigationTitle = "純積分"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func pressedShowMarkAndMoney(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as? DetailStoreMarkController {
            vc.typeRequest = TypeProductRequest.pointAndMoney
            vc.navigationTitle = "積分＋現金"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
