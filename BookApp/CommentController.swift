//
//  CommentController.swift
//  BookApp
//
//  Created by kien le van on 8/28/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class CommentController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var botLayoutCommentView: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    
    var tap: UITapGestureRecognizer?
    var arrayOfComment = [Comment]()
    var idObject: Int?
    var commentType: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentView.isHidden = true
        table.estimatedRowHeight = 140
        table.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification1:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        commentTextView.delegate = self
        let getComment: GetAllComment = GetAllComment(commentType: commentType!,
                                                      idObject: idObject!,
                                                      limitComment: 20,
                                                      pageing: 1)
        requestWithTask(task: getComment, success: { (data) in
            self.arrayOfComment = data as! [Comment]
            self.table.reloadData()
        }) { (error) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfComment.count
//        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let commenObject = arrayOfComment[indexPath.row]
        cell.binData(commentObject: commenObject)
        cell.pressLikeComment = { [weak self] in
            let likeComment: LikeTask = LikeTask(likeType: 2,
                                                 memberID: 1,
                                                 objectId: commenObject.id)
            self?.requestWithTask(task: likeComment, success: { (data) in
                let status: Like = (data as? Like)!
                var currentLike: Int = Int(cell.numberLike.text!)!
                if status == Like.LIKE {
                    currentLike += 1
                    cell.numberLike.text = String(currentLike)
                } else {
                    currentLike -= 1
                    cell.numberLike.text = String(currentLike)
                }
                
            }, failure: { (error) in
                
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func pressedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func pressedWriteButton(_ sender: Any) {
        commentTextView.becomeFirstResponder()
    }
    
    @IBAction func pressedSendComment(_ sender: Any) {
        let sendComment: SendCommentTask = SendCommentTask(commentType: commentType!,
                                                           memberID: 1,
                                                           objectId: idObject!,
                                                           content: commentTextView.text)
        requestWithTask(task: sendComment, success: { (data) in
            self.commentTextView.text = ""
            self.commentTextView.endEditing(true)
            print(data!)
        }) { (error) in
            
        }
    }
   
    @objc func keyboardNotification(notification1: NSNotification) {
        if let userInfo = notification1.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                commentView.isHidden = true
                view.removeGestureRecognizer(tap!)
                botLayoutCommentView.constant = 0.0
            } else {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                commentView.isHidden = false
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                botLayoutCommentView.constant = (endFrame?.size.height)!
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
            //            DispatchQueue.main.async(execute: {
            //                self.scrollLastMessage()
            //            })
        }
    }
    
    func dismissKeyboard() {
        commentTextView.endEditing(true)
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self)
    }
}
