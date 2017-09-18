//
//  DetailSingleGroupViewController.swift
//  BookApp
//
//  Created by kien le van on 9/11/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailSingleGroupViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var heightOfImage: NSLayoutConstraint!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var idWeChat: UILabel!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var table: UITableView!
    var groupSelected: SecrectGroup?
    var arrayNews = [NewsInGroups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adress.text = groupSelected?.adress
        idWeChat.text = groupSelected?.idWechat
        nameGroup.text = groupSelected?.name
        imageGroup.sd_setImage(with: URL(string: (groupSelected?.imageURL)!), placeholderImage: #imageLiteral(resourceName: "userPlaceHolder"))
        
        imageGroup.layer.cornerRadius = heightOfImage.constant / 2
        let getNewsInGroup: GetNewsInGroupTask =
            GetNewsInGroupTask(idGroup: (groupSelected?.idGroup)!,
                               limit: 20,
                               page: 1)
        requestWithTask(task: getNewsInGroup, success: { (data) in
            if let  array = data as? [NewsInGroups] {
                self.arrayNews = array
                self.table.reloadData()
            }
        }) { (error) in
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DetailSingleGroupCell {
            cell.binData(news: arrayNews[indexPath.row])
        return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func pressedJoinButton(_ sender: Any) {
        
    }
}
