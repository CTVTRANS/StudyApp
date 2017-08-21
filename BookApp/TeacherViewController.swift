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
    var suggestArray = [Teacher]()
    var freeArray = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callBack()
        let teacher1: Teacher = Teacher(name: "kien le van", imageURL: "abc")
        let teacher2: Teacher = Teacher(name: "le van kien", imageURL: "123")
        let teacher3: Teacher = Teacher(name: "van", imageURL: "123")
        suggestArray.append(teacher1)
        suggestArray.append(teacher2)
        suggestArray.append(teacher3)
        suggestTeacher.arrTeacher = suggestArray
        
        let teacher4: Teacher = Teacher(name: "apple", imageURL: "abc")
        let teacher5: Teacher = Teacher(name: "macbook", imageURL: "123")
        let teacher6: Teacher = Teacher(name: "iphone", imageURL: "123")
        freeArray.append(teacher4)
        freeArray.append(teacher5)
        freeArray.append(teacher6)
        freeTeacher.arrTeacher = freeArray
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func callBack() {
        let teacherStoryboard = UIStoryboard(name: "Teacher", bundle: nil)
        suggestTeacher.callBackClickCell = {[weak self] (teacherSelected: Teacher) in
            let detailTeacherVC: DetailTeacherViewController = teacherStoryboard.instantiateViewController(withIdentifier: "DetailTeacherViewController") as! DetailTeacherViewController
            detailTeacherVC.teacher = teacherSelected
            self?.navigationController?.pushViewController(detailTeacherVC, animated: true)
        }
        
        freeTeacher.callBackClickCell = {[weak self] (teacherSelected: Teacher) in
            let detailTeacherVC: DetailTeacherViewController = teacherStoryboard.instantiateViewController(withIdentifier: "DetailTeacherViewController") as! DetailTeacherViewController
            detailTeacherVC.teacher = teacherSelected
            self?.navigationController?.pushViewController(detailTeacherVC, animated: true)
        }
    }

    @IBAction func showDetailTeacher(_ sender: Any) {

    }
    
    @IBAction func showSubcribeed(_ sender: Any) {
        let teacherStoryboard = UIStoryboard(name: "Teacher", bundle: nil)
        let controller: TeacherSubscribeController = teacherStoryboard.instantiateViewController(withIdentifier: "TeacherSubscribeController") as! TeacherSubscribeController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
