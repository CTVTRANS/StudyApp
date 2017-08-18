//
//  CustomTeacherCollection.swift
//  BookApp
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class CustomTeacherCollection: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var callBackClickCell:((Teacher) -> Void) = {_ in }
    var arrTeacher = [Teacher]()

    @IBOutlet weak var teacherCollection: UICollectionView!
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        self.teacherCollection.register(UINib(nibName: "TeacherCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        let teacher1: Teacher = Teacher(name: "kien", imageURL: "abc")
        let teacher2: Teacher = Teacher(name: "le", imageURL: "123")
        let teacher3: Teacher = Teacher(name: "van", imageURL: "123")
        arrTeacher.append(teacher1)
        arrTeacher.append(teacher2)
        arrTeacher.append(teacher3)
    }
    
    private func setupUI() {
        let view = viewfromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleHeight,
            UIViewAutoresizing.flexibleWidth
        ]
        addSubview(view)
    }
    
    private func viewfromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TeacherCollectionCell = teacherCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TeacherCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthSpace: CGFloat = 11
        widthSpace.adjustsSizeToRealIPhoneSize = 11
        let widthPerItem = (teacherCollection.frame.size.width - widthSpace * 2) / 3 - 1
        let hightPerItem = teacherCollection.frame.size.height
        
        return CGSize(width: widthPerItem, height: hightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        var space: CGFloat = 11
        space.adjustsSizeToRealIPhoneSize = 11
        return space
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBackClickCell(arrTeacher[indexPath.row])
    }

}
