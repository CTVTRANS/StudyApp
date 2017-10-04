//
//  ShareController.swift
//  BookApp
//
//  Created by kien le van on 9/21/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import Social

class ShareController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShareViewCell
        switch indexPath.row {
        case 0:
            cell?.imageShare.image = #imageLiteral(resourceName: "ic_share_weibo")
        case 1:
            cell?.imageShare.image = #imageLiteral(resourceName: "ic_share_wechat")
        case 2:
            cell?.imageShare.image = #imageLiteral(resourceName: "ic_share_facebook")
        default:
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            pressedShareWeibo()
        case 1:
            pressedShareWechat()
        case 2:
            pressedShareFacebook()
        default:
            break
        }
    }
    
    func pressedShareWeibo() {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo) {
            let vc = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo)
//            vc?.add(#imageLiteral(resourceName: "userPlaceHolder"))
//            vc?.add(URL(string: "https://color.adobe.com/explore/most-popular/?time=all"))
            vc?.setInitialText("Hello\n")
            vc?.popoverPresentationController?.sourceView = self.view
            vc?.completionHandler = { status in
                switch status {
                case SLComposeViewControllerResult.done:
                    print("ok")
                case SLComposeViewControllerResult.cancelled:
                    break
                }
            }
            self.present(vc!, animated: true, completion: nil)
        } else {
            _ = UIAlertController(title: "waring", message: "please install weibo and sigin weibo for share", preferredStyle: .alert)
        }
    }
    
    func pressedShareWechat() {
//        let message = SendMessageToWXReq()
//        message.text = "Hello WeChat"
//        message.bText = true
//        message.scene = 1
//        WXApi.send(message)
        let textToShare = "Hello\n"
        let iamge = #imageLiteral(resourceName: "userPlaceHolder")
        if let myWebsite = NSURL(string: "https://www.youtube.com/") {
            let objectsToShare = [textToShare, iamge, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.postToFacebook,
                                                UIActivityType.postToTwitter,
                                                UIActivityType.postToVimeo,
                                                UIActivityType.postToTencentWeibo,
                                                UIActivityType.print,
                                                UIActivityType.airDrop,
                                                UIActivityType.copyToPasteboard,
                                                UIActivityType.assignToContact,
                                                UIActivityType.saveToCameraRoll,
                                                UIActivityType.addToReadingList,
                                                UIActivityType.postToFlickr,
                                                UIActivityType.mail,
                                                UIActivityType.postToWeibo
                                                ]
            activityVC.completionWithItemsHandler = { (activity, success, items, error) in                print(success ? "SUCCESS!" : "FAILURE")
            }
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func pressedShareFacebook() {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            vc?.add(#imageLiteral(resourceName: "userPlaceHolder"))
            vc?.add(URL(string: "https://color.adobe.com/explore/most-popular/?time=all"))
            vc?.setInitialText("Hello\n")
            vc?.popoverPresentationController?.sourceView = self.view
            vc?.completionHandler = { status in
                switch status {
                case SLComposeViewControllerResult.done:
                    print("ok")
                case SLComposeViewControllerResult.cancelled:
                    break
                }
            }
            self.present(vc!, animated: true, completion: nil)
        }
    }
}
