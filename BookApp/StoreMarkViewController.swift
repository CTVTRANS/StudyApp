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
        let cell: StoreMarkViewCell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StoreMarkViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (widthScreen - 10) / 2
        return CGSize(width: widthCell, height: widthCell + 20.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressedShowAllButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as! DetailStoreMarkController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func pressedShowMarkButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as! DetailStoreMarkController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func pressedShowMarkAndMoney(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStoreMarkController") as! DetailStoreMarkController
        navigationController?.pushViewController(vc, animated: true)
    }
}
