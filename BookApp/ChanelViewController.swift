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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        callBack()
        setupCallBackNavigation()
        suggestChanel.name.text = "--"
        freeChanel.name.text = "--"
        let getChanelSuggest: GetChanelSuggestTask =
            GetChanelSuggestTask(lang: Constants.sharedInstance.language,
                                 limit: 3,
                                 page: 1)
        requestWithTask(task: getChanelSuggest, success: { [weak self] (data) in
            let suggestArray: [Chanel] = data as! [Chanel]
            self?.suggestChanel.reloadChanel(arrayChanel: suggestArray)
            self?.loadedChanelSuggest = true
            if (self?.loadedChanelSuggest)! && (self?.loadedChanelFree)! {
                self?.stopActivityIndicator()
            }
        }) { (error) in
            
        }
        let getFreeChanel: GetChanelFreeTask =
            GetChanelFreeTask(lang: Constants.sharedInstance.language,
                              limit: 3,
                              page: 1)
        requestWithTask(task: getFreeChanel, success: { [weak self] (data) in
            let freeArray: [Chanel] = data as! [Chanel]
            self?.freeChanel.reloadChanel(arrayChanel: freeArray)
            self?.loadedChanelFree = true
            if (self?.loadedChanelSuggest)! && (self?.loadedChanelFree)! {
                self?.stopActivityIndicator()
            }
        }) { (error) in
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func callBack() {
        let teacherStoryboard = UIStoryboard(name: "Chanel", bundle: nil)
        suggestChanel.callBackClickCell = {[weak self] (teacherSelected: Chanel) in
            let detailTeacherVC: DetailChanelViewController = teacherStoryboard.instantiateViewController(withIdentifier: "DetailChanelViewController") as! DetailChanelViewController
            detailTeacherVC.teacher = teacherSelected
            self?.navigationController?.pushViewController(detailTeacherVC, animated: true)
        }
        
        freeChanel.callBackClickCell = {[weak self] (teacherSelected: Chanel) in
            let detailTeacherVC: DetailChanelViewController = teacherStoryboard.instantiateViewController(withIdentifier: "DetailChanelViewController") as! DetailChanelViewController
            detailTeacherVC.teacher = teacherSelected
            self?.navigationController?.pushViewController(detailTeacherVC, animated: true)
        }
    }
    
    func setupCallBackNavigation() {
        navigationView.callBackTopButton = { [weak self] (typeButton: TopButton) in
            let myStoryboard = UIStoryboard(name: "Global", bundle: nil)
            switch typeButton {
            case TopButton.messageNotification:
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationMessageViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.videoNotification:
                let vc: UINavigationController = myStoryboard.instantiateViewController(withIdentifier: "NotificationVideoViewController") as! UINavigationController
                self?.present(vc, animated: true, completion: nil)
            case TopButton.search:
                let vc: SearchViewController = myStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func showDetailTeacher(_ sender: Any) {
        
    }
    
    @IBAction func showSubcribeed(_ sender: Any) {
        let teacherStoryboard = UIStoryboard(name: "Chanel", bundle: nil)
        let controller: ChanelSubscribeController = teacherStoryboard.instantiateViewController(withIdentifier: "ChanelSubscribeController") as! ChanelSubscribeController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
