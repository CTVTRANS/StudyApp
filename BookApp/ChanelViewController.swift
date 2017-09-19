//
//  ChanelViewController.swift
//  BookApp
//
//  Created by kien le van on 9/5/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class ChanelViewController: BaseViewController {

    @IBOutlet weak var navigationView: NavigationCustom!
    @IBOutlet weak var suggestChanel: CustomChanelCollection!
    @IBOutlet weak var freeChanel: CustomChanelCollection!
    private var loadedChanelSuggest = false
    private var loadedChanelFree = false
    var currentPageSuggest = 1
    var currentFree = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        callBack()
        setupCallBackNavigation()
        suggestChanel.name.text = "熱門老師"
        freeChanel.name.text = "猜你喜歡"
        getData()
        let getChaelSubcrible: GetAllChanelSubcribledTask = GetAllChanelSubcribledTask(memberID: 1)
        requestWithTask(task: getChaelSubcrible, success: { (_) in
            
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getData() {
        let getChanelSuggest: GetChanelSuggestTask =
            GetChanelSuggestTask(lang: Constants.sharedInstance.language,
                                 limit: 3,
                                 page: currentPageSuggest)
        requestWithTask(task: getChanelSuggest, success: { [weak self] (data) in
            if let suggestArray = data as? [Chanel] {
                self?.currentPageSuggest += 1
                self?.suggestChanel.reloadChanel(arrayChanel: suggestArray)
                self?.loadedChanelSuggest = true
                if (self?.loadedChanelSuggest)! && (self?.loadedChanelFree)! {
                    self?.stopActivityIndicator()
                }
            }
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }
        let getFreeChanel: GetChanelFreeTask =
            GetChanelFreeTask(lang: Constants.sharedInstance.language,
                              limit: 3,
                              page: currentFree)
        requestWithTask(task: getFreeChanel, success: { [weak self] (data) in
            if let freeArray = data as? [Chanel] {
                self?.currentFree += 1
                self?.freeChanel.reloadChanel(arrayChanel: freeArray)
                self?.loadedChanelFree = true
                if (self?.loadedChanelSuggest)! && (self?.loadedChanelFree)! {
                    self?.stopActivityIndicator()
                }
            }
        }) { (error) in
            self.stopActivityIndicator()
            _ = UIAlertController(title: nil,
                                  message: error as? String,
                                  preferredStyle: .alert)
        }

    }
    
    func callBack() {
        let teacherStoryboard = UIStoryboard(name: "Chanel", bundle: nil)
        suggestChanel.callBackClickCell = {[weak self] (chanelSelected: Chanel) in
            if let detailTeacherVC = teacherStoryboard.instantiateViewController(withIdentifier: "DetailChanelViewController") as? DetailChanelViewController {
                detailTeacherVC.chanel = chanelSelected
                self?.navigationController?.pushViewController(detailTeacherVC, animated: true)
            }
        }
        
        freeChanel.callBackClickCell = {[weak self] (chanelSelected: Chanel) in
            if let detailTeacherVC = teacherStoryboard.instantiateViewController(withIdentifier: "DetailChanelViewController") as? DetailChanelViewController {
                detailTeacherVC.chanel = chanelSelected
                self?.navigationController?.pushViewController(detailTeacherVC, animated: true)
            }
        }
    }
    
    func setupCallBackNavigation() {
        navigationView.callBackTopButton = { [weak self] (typeButton: TopButton) in
            let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
            switch typeButton {
            case TopButton.messageNotification:
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "NotificationMessageViewController") as? UINavigationController {
                    self?.present(vc, animated: true, completion: nil)
                }
            case TopButton.videoNotification:
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "NotificationVideoViewController") as? UINavigationController {
                    self?.present(vc, animated: true, completion: nil)
                }
            case TopButton.search:
                if let vc = myStoryboard.instantiateViewController(withIdentifier: "Search") as? UINavigationController {
                    self?.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func showHotChanel(_ sender: Any) {
        let chanelStoryboard = UIStoryboard(name: "Chanel", bundle: nil)
        if let vc = chanelStoryboard.instantiateViewController(withIdentifier: "ChanelHotController") as? ChanelHotController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func showSubcribeed(_ sender: Any) {
        let chanelStoryboard = UIStoryboard(name: "Chanel", bundle: nil)
        if let controller = chanelStoryboard.instantiateViewController(withIdentifier: "ChanelSubscribeController") as? ChanelSubscribeController {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func loadMore(_ sender: Any) {
        getData()
    }
}
