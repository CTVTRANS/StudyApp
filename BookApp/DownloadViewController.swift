//
//  DownloadViewController.swift
//  BookApp
//
//  Created by kien le van on 9/27/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class DownloadViewController: BaseViewController {
    
    private var downloadAuidosucess = false
    private var downloadImageSuccess = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func downloadBook(book: Book) {
        let downloadImage = DownloadTask(path: book.imageURL)
        downloadFileSuccess(task: downloadImage, success: { (data) in
            if let imageOflline = data as? URL {
                self.downloadImageSuccess = true
                book.imageOffline = imageOflline
                if self.downloadAuidosucess && self.downloadImageSuccess {
                    self.saveAudio(book: book)
                }
            }
        }) { (_) in
        }
        let downloadAudio = DownloadTask(path: book.audio)
        downloadFileSuccess(task: downloadAudio, success: { (data) in
            if let audioOffline = data as? URL {
                self.downloadAuidosucess = true
                book.audioOffline = audioOffline
                if self.downloadAuidosucess && self.downloadImageSuccess {
                    self.saveAudio(book: book)
                }
            }
        }) { (_) in
        }
    }
    
    func downloadLesson(lesson: Lesson) {
//        lesson.chanelOwner = chanel.nameChanel
        let downloadImageLesson = DownloadTask(path: lesson.imageChapURL)
        downloadFileSuccess(task: downloadImageLesson, success: { (data) in
            if let imageOffline = data as? URL {
                lesson.imageOffline = imageOffline
                self.downloadImageSuccess = true
                if self.downloadImageSuccess && self.downloadAuidosucess {
                    self.setListLesson(chap: lesson)
                }
            }
        }) { (_) in
        }
        
        let downloadLesson = DownloadTask(path: lesson.contentURL)
        downloadFileSuccess(task: downloadLesson, success: { (data) in
            if let audioOffline = data as? URL {
                lesson.audioOffline = audioOffline
                self.downloadImageSuccess = true
                if self.downloadImageSuccess && self.downloadAuidosucess {
                    self.setListLesson(chap: lesson)
                }
            }
        }) { (_) in
        }
    }
    
    func saveAudio(book: Book) {
        var listBookDownaloaed = Book.getBook()
        for singleBook in listBookDownaloaed! where singleBook.idBook == book.idBook {
            return
        }
        listBookDownaloaed?.append(book)
        Book.saveBook(myBook: listBookDownaloaed!)
    }
    
    func setListLesson(chap: Lesson) {
        var listLesson = Lesson.getLesson()
        for singleLesson in listLesson! where chap.idChap == singleLesson.idChap {
            return
        }
        listLesson?.append(chap)
        Lesson.saveLesson(lesson: listLesson!)
        print("sucess")
    }
}
