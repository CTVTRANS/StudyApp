//
//  HisToryWatchChanelCell.swift
//  BookApp
//
//  Created by kien le van on 9/7/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class HistoryWatchChanelCell: UITableViewCell {

    @IBOutlet weak var timeUpLesson: UILabel!
    @IBOutlet weak var descriptionLesson: UILabel!
    @IBOutlet weak var nameLesson: UILabel!
    @IBOutlet weak var nameChanel: UILabel!
    @IBOutlet weak var numberChap: UILabel!
    @IBOutlet weak var removeChanelButton: UIButton!
    @IBOutlet weak var playChanelButton: UIButton!
    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var imagePlay: UIImageView!
    
    var callBackButton:((_ action: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playChanelButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        removeChanelButton.layer.borderColor = UIColor.rgb(r: 255, g: 102, b: 0).cgColor
        avatar.layer.cornerRadius = heightOfAvatar.constant / 2
    }
    
    func binData(lesson: Lesson) {
        let date = lesson.timeUp.components(separatedBy: " ")
        timeUpLesson.text = date[0]
        descriptionLesson.text = lesson.descriptionChap
        nameLesson.text = lesson.name
        numberChap.text = String(lesson.chapter)
        nameChanel.text = lesson.chanelOwner
    }
    
    @IBAction func pressedPlayChanelButton(_ sender: Any) {
        self.callBackButton!("playChanel")
    }
    
    @IBAction func pressedRemoveChanelButton(_ sender: Any) {
        self.callBackButton!("removeChanel")
    }

}
