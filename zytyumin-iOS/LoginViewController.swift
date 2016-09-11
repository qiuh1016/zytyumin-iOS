//
//  LoginViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonToViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelToBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var viewToViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupLabel: UILabel!
    
    var buttonToBottom: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNotification()
        initTap()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    func initView() {
        loginButton.layer.cornerRadius = 5
        
        if self.view.bounds.height == 568 {
            imageToTopConstraint.constant = 80
            viewToViewConstraint.constant = -3
            buttonToViewConstraint.constant = 22
            buttonToBottomConstraint.constant = 55
            labelToBottomContraint.constant = 20
        } else if self.view.bounds.height == 480 {
            imageToTopConstraint.constant = 40
            viewToViewConstraint.constant = -3
            buttonToViewConstraint.constant = 15
            buttonToBottomConstraint.constant = 45
            labelToBottomContraint.constant = 15
        } else if self.view.bounds.height == 736 {
            imageWidthConstraint.constant = 180
        }
        self.view.layer.layoutIfNeeded()
        buttonToBottom = buttonToBottomConstraint.constant
        
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func initNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func initTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.closeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func keyboardWillAppear(notification: NSNotification){
    
        let keyboardInfo = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]
        let keyboardHeight = keyboardInfo?.CGRectValue.size.height
        
        //加这个判断 防止在两个输入框之间切换的时候进行动画 原因不明
        if buttonToBottomConstraint.constant == buttonToBottom {
        
            buttonToBottomConstraint.constant = keyboardHeight! + 10
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
                self.view.layer.layoutIfNeeded()
                self.imageView.alpha = 0
                self.signupLabel.alpha = 0
                }, completion: nil)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        buttonToBottomConstraint.constant = buttonToBottom
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layer.layoutIfNeeded()
            self.imageView.alpha = 1
            self.signupLabel.alpha = 1
        }, completion: nil)
    }
    
    func closeKeyboard() {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signupLabelTapped(sender: AnyObject) {
        print("signupLabelTapped")
    }
    
    @IBAction func forgetPasswordLabelTapped(sender: AnyObject) {
        print("forgetPasswordLabelTapped")
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if textField == accountTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
}
