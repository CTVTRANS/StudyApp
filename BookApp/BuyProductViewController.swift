//
//  BuyProductViewController.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class BuyProductViewController: BaseViewController {

    @IBOutlet weak var statusTranfer: UILabel!
    @IBOutlet weak var numberMark: UILabel!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var buyButton_Case1: UIButton!
    @IBOutlet weak var buyButton_Case2: UIButton!
    
    @IBOutlet weak var point1: UILabel!
    @IBOutlet weak var money1: UILabel!
    
    @IBOutlet weak var point2: UILabel!
    @IBOutlet weak var money2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton_Case1.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        buyButton_Case2.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    @IBAction func pressedBuyButtonCase1(_ sender: Any) {
    }
    @IBAction func pressedBuyButtonCase2(_ sender: Any) {
    }

}
