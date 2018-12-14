//
//  TextFieldViewController.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 7/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import UIKit

class TextFieldVC: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)
        setupView()
        
    }
    
    func setupView(){
        self.title = "TextField"
        hideKeyboard()
    }
    
    
    
    //MARK: Methods to manage keybaord
    @objc func keyboardDidShow(notification: NSNotification) {
        
        var info = notification.userInfo
        let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollview.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height + 16, right: 0.0)
        scrollview.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        
        scrollview.contentInset = UIEdgeInsets.zero
        scrollview.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
}

extension TextFieldVC {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(TextFieldVC.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        scrollview.contentInset = UIEdgeInsets.zero
        scrollview.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
