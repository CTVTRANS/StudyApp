//
//  TeacherViewController.swift
//  BookApp
//
//  Created by Le Cong on 8/12/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class TeacherViewController: BaseViewController {

    @IBOutlet weak var suggestTeacher: CustomTeacherCollection!
    @IBOutlet weak var freeTeacher: CustomTeacherCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func showDetailTeacher(_ sender: Any) {
        let teacherStoryboard = UIStoryboard(name: "Teacher", bundle: nil)
        let controller: DetailTeacherViewController = teacherStoryboard.instantiateViewController(withIdentifier: "DetailTeacherViewController") as! DetailTeacherViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func showSubcribeed(_ sender: Any) {
        let teacherStoryboard = UIStoryboard(name: "Teacher", bundle: nil)
        let controller: TeacherSubscribeController = teacherStoryboard.instantiateViewController(withIdentifier: "TeacherSubscribeController") as! TeacherSubscribeController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
