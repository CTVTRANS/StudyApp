//
//  MarkViewController.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class StoreMarkViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(UINib.init(nibName: "StoreMarkViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StoreMarkViewCell {
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
                return header
            }
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as? BuyProductViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressedShowAllButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as? DetailStoreMarkController {
            vc.typeRequest = 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func pressedShowMarkButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as? DetailStoreMarkController {
            vc.typeRequest = 2
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func pressedShowMarkAndMoney(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as? DetailStoreMarkController {
            vc.typeRequest = 3
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
