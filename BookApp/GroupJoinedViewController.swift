//
//  GroupJoinedViewController.swift
//  BookApp
//
//  Created by kien le van on 9/8/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class GroupJoinedViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var listGroupJoind = [SecrectGroup]()
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "線下活動"
        let getGroupJoined: GetGroupJoinedTask = GetGroupJoinedTask(id: 1)
        requestWithTask(task: getGroupJoined, success: { (data) in
            self.listGroupJoind = data as! [SecrectGroup]
            Constants.sharedInstance.listGroupJoined = data as? [SecrectGroup]
            self.collection.reloadData()
        }) { (error) in
            
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listGroupJoind.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GroupJoinedCell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GroupJoinedCell
        cell.binData(group: listGroupJoind[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (widthScreen - 20.0)  / 4
        let sizeCell = CGSize(width: widthCell, height: widthCell)
        return sizeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: DetailSingleGroupViewController = storyboard?.instantiateViewController(withIdentifier: "DetailSingleGroupViewController") as! DetailSingleGroupViewController
        vc.groupSelected = listGroupJoind[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
