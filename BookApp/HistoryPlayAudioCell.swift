//
//  VideoNotificationCell.swift
//  BookApp
//
//  Created by kien le van on 9/4/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class HistoryPlayAudioCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionAudio: UILabel!
    var book: Book?
    var callBackDownload:((_ book: Book) -> Void) = {_ in }
    var callBackPlayAudio:((_ book: Book) -> Void) = {_ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bindData(historyBook: Book) {
        book = historyBook
        name.text = historyBook.name
        let arrayString = historyBook.descriptionBook.components(separatedBy: "</p>")
        let firstString = arrayString[0]
        let index = firstString.index(firstString.startIndex, offsetBy: 4)
        descriptionAudio.text = firstString.substring(from: index)
    }
    
    @IBAction func pressedplayAudio(_ sender: Any) {
        self.callBackPlayAudio(book!)
    }
    
    @IBAction func pressedDownload(_ sender: Any) {
        self.callBackDownload(book!)
    }
}
