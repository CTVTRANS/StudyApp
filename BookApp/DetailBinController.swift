//
//  DetailBinController.swift
//  BookApp
//
//  Created by kien le van on 9/23/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DetailBinController: BaseViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var numberPhone: UITextField!
    @IBOutlet weak var adress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func pressedSaveAdress(_ sender: Any) {
        
    }

    @IBAction func pressedCancel(_ sender: Any) {
        
    }
}
