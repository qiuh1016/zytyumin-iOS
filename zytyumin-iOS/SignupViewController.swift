//
//  signupViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/12/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var buttonToViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelToBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    
    var isPersonalAccount = true
    
    var buttonToBottom: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initTap()
        initNotification()
    }
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func initView() {
        signupButton.layer.cornerRadius = kCornerRadii
        switchButton.layer.cornerRadius = kCornerRadii
        
        signupButton.backgroundColor = UIColor.mainColor()
        
        if self.view.bounds.height == 568 {
            buttonToViewConstraint.constant = 22
            buttonToBottomConstraint.constant = 55
            labelToBottomContraint.constant = 20
        } else if self.view.bounds.height == 480 {
            buttonToViewConstraint.constant = 15
            buttonToBottomConstraint.constant = 36
            labelToBottomContraint.constant = 10
            buttonHeightConstraint.constant = 45
        } else if self.view.bounds.height == 736 {
            //
        }
        self.view.layer.layoutIfNeeded()
        buttonToBottom = buttonToBottomConstraint.constant
        
        accountTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nameTextField.delegate = self
        idTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    func initTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.closeKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func initNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignupViewController.keyboardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignupViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillAppear(notification: NSNotification){
        
        let keyboardInfo = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]
        let keyboardHeight = keyboardInfo?.CGRectValue.size.height
        
        if (nameTextField.isFirstResponder() || idTextField.isFirstResponder() || emailTextField.isFirstResponder()) {
            //加这个判断 防止在两个输入框之间切换的时候进行动画 原因不明
            if buttonToBottomConstraint.constant == buttonToBottom {
                
                buttonToBottomConstraint.constant = keyboardHeight! + 10
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
                    self.view.layer.layoutIfNeeded()
                    }, completion: nil)
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        buttonToBottomConstraint.constant = buttonToBottom
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layer.layoutIfNeeded()
            }, completion: nil)
    }

    
    func closeKeyboard() {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        idTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func switchButtonTapped(sender: AnyObject) {
        nameLabel.text = isPersonalAccount ? "企业名称" : "姓名"
        idLabel.text = isPersonalAccount ? "企业编号" : "身份证"
        switchButton.setTitle(isPersonalAccount ? "个人账号注册" : "企业账号注册", forState: .Normal)
        isPersonalAccount = !isPersonalAccount
        
        nameTextField.text = ""
        idTextField.text = ""
    }
    

}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if textField == accountTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField{
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            idTextField.becomeFirstResponder()
        } else if textField == idTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            emailTextField.resignFirstResponder()
        }
        return true
    }
    
}
