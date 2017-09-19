//
//  DetailStoreMarkController.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import LCNetwork

class DetailStoreMarkController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    private var page = 1
    var typeRequest: TypeProductRequest!
//    private var listBook: [Book] = []
//    private var listVip: [Vip] = []
    private var listProduct: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib.init(nibName: "StoreMarkViewCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
        getProduct()
    }
    
    func getProduct() {
        let getAllproduct: GetAllproductTask = GetAllproductTask(limit: 20, page: page)
        let getProductByPoint: GetListProductByPointTask = GetListProductByPointTask(limit: 20, page: page)
        let getproductByPointAndMoney: GetListProductByPointAndMoneyTask = GetListProductByPointAndMoneyTask(limit: 20, page: page)
        
        if typeRequest == TypeProductRequest.all {
            let getProductVip: GetProductVipTask = GetProductVipTask()
            requestWithTask(task: getProductVip, success: { (data) in
                if let arrayVip = data as? [Vip] {
                    self.listProduct = arrayVip
                    self.getProductBookWith(task: getAllproduct)
                }
            }, failure: { (_) in
                
            })
        } else if typeRequest == TypeProductRequest.point {
            getProductBookWith(task: getProductByPoint)
        } else {
            getProductBookWith(task: getproductByPointAndMoney)
        }
    }
    
    func getProductBookWith(task: BaseTaskNetwork) {
        requestWithTask(task: task, success: { (data) in
            if let list = data as? [Book] {
//                self.listBook = list
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? StoreMarkViewCell {
        cell.binData(product: listProduct[indexPath.row], type: typeRequest)
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (widthScreen - 10) / 2
        return CGSize(width: widthCell, height: widthCell + 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as? BuyProductViewController {
            vc.product = listProduct[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
