//
//  TeacherCollectionCell.swift
//  BookApp
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class TeacherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nameTeacher: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func binData(teacher: Teacher) {
        nameTeacher.text = teacher.name
    }

}
