//
//  DetailStoreMarkController.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailStoreMarkController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    private var page = 1
    var typeRequest: Int!
    var listProduct: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib.init(nibName: "StoreMarkViewCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
        getData()
    }
    
    func getData() {
        let getAllproduct: GetAllproductTask = GetAllproductTask(limit: 20, page: page)
        let getProductByPoint: GetListProductByPoint = GetListProductByPoint(limit: 20, page: page)
        let getproductByPointAndMoney: GetListProductByPointAndMoney = GetListProductByPointAndMoney(limit: 20, page: page)
        if typeRequest == 1 {
            requestWithTask(task: getAllproduct, success: { (data) in
                self.listProduct = data as! [Book]
                self.collection.reloadData()
            }, failure: { (error) in
                
            })
        } else if (typeRequest == 2) {
            requestWithTask(task: getProductByPoint, success: { (data) in
                self.listProduct = data as! [Book]
                self.collection.reloadData()
            }, failure: { (error) in
                
            })
        } else {
            requestWithTask(task: getproductByPointAndMoney, success: { (data) in
                self.listProduct = data as! [Book]
                self.collection.reloadData()
            }, failure: { (error) in
                
            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! StoreMarkViewCell
        cell.binData(book: listProduct[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (widthScreen - 10) / 2
        return CGSize(width: widthCell, height: widthCell + 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
        vc.product = listProduct[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
