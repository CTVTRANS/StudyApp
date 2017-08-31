//
//  SplashViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.borderColor = UIColor.rgb(r: 113, g: 112, b: 110).cgColor
    }
    
    @IBAction func pressedStartButton(_ sender: Any) {
        let vc: UITabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.present(vc, animated: false, completion: nil)
    }

}
