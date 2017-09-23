//
//  SplashViewController.swift
//  BookApp
//
//  Created by kien le van on 8/29/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import SWRevealViewController

class SplashViewController: BaseViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.borderColor = UIColor.rgb(red: 113, green: 112, blue: 110).cgColor
    }
    
    @IBAction func pressedStartButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            self.present(vc, animated: false, completion: nil)
        }
    }

}
