//
//  LoginViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageWidthConstraint     : NSLayoutConstraint!
    @IBOutlet weak var imageToTopConstraint     : NSLayoutConstraint!
    @IBOutlet weak var buttonToViewConstraint   : NSLayoutConstraint!
    @IBOutlet weak var buttonToBottomConstraint : NSLayoutConstraint!
    @IBOutlet weak var labelToBottomContraint   : NSLayoutConstraint!
    @IBOutlet weak var viewToViewConstraint     : NSLayoutConstraint!
    @IBOutlet weak var buttonHeightConstraint   : NSLayoutConstraint!
    
    @IBOutlet weak var loginButton      : UIButton!
    @IBOutlet weak var imageView        : UIImageView!
    @IBOutlet weak var accountTextField : UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupLabel      : UILabel!
    
    var buttonToBottom: CGFloat!
    var viewWillDisappear = false
    var hudView: HudView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNotification()
        initTap()
        
        UIApplication.sharedApplication().statusBarStyle = .Default

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.view.sendSubviewToBack((self.navigationController?.navigationBar)!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        viewWillDisappear = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        viewWillDisappear = true
    }
    
    func initView() {
        
        let account = defaults.objectForKey("username")
        if let acc = account {
            accountTextField.text = acc as? String
        }
        
        loginButton.layer.cornerRadius = kCornerRadii
        loginButton.backgroundColor = UIColor.mainColor()
        
        if self.view.bounds.height == 568 {
            imageToTopConstraint    .constant = 80 - 64
            viewToViewConstraint    .constant = -3
            buttonToViewConstraint  .constant = 22
            buttonToBottomConstraint.constant = 55
            labelToBottomContraint  .constant = 20
            buttonHeightConstraint  .constant = 45
        } else if self.view.bounds.height == 480 {
            imageToTopConstraint    .constant = 40 - 40
            viewToViewConstraint    .constant = -3
            buttonToViewConstraint  .constant = 15
            buttonToBottomConstraint.constant = 36
            labelToBottomContraint  .constant = 10
            buttonHeightConstraint  .constant = 45
        } else if self.view.bounds.height == 736 {
            imageWidthConstraint    .constant = 180
        }
        self.view.layer.layoutIfNeeded()
        buttonToBottom = buttonToBottomConstraint.constant
        
        accountTextField .delegate = self
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
        if buttonToBottomConstraint.constant == buttonToBottom && !viewWillDisappear {
        
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
        performSegueWithIdentifier("signupSegue", sender: nil)
    }
    
    @IBAction func forgetPasswordLabelTapped(sender: AnyObject) {
        print("forgetPasswordLabelTapped")
        performSegueWithIdentifier("smsSegue", sender: nil)
    }
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let account = accountTextField.text
        let password = passwordTextField.text
        
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if account == nil || password == nil {
            return
        }
        
        hudView = HudView.hudInView(self.view, animated: false)
        hudView.text = "登录中"
        
        Alamofire.request(.GET, serverIP + loginUrl, parameters: ["loginName": account!, "password": password!.MD5, "deviceType": 0, "clientId": 1]).responseJSON(completionHandler: { response in
            switch response.result {
            case .Success(let value):
                self.hudView.hideAnimated(self.view, animated: true)
                print(JSON(value))
                let code = JSON(value)["Code"].intValue
                if code == 0 {
                    
                    let sessionKey = JSON(value)["SessionKey"].stringValue

                    let logonUser = JSON(value)["LogonUser"]
                    let shipsJSON: [JSON] = logonUser["Ships"].arrayValue
                    let idCard = logonUser["IDCard"].stringValue
                    var ships = [Ship]()
                    for shipJSON in shipsJSON {
                        let ship = Ship()
                        ship.number = shipJSON["ShipNo"].stringValue
                        ship.coor = CLLocationCoordinate2DMake(shipJSON["Latitude"].doubleValue / 600000, shipJSON["Longitude"].doubleValue / 600000)
                        ship.name = shipJSON["ShipName"].stringValue
                        ship.deviceInstall = shipJSON["DeviceInstall"].boolValue
                        ships.append(ship)
                    }
                    
                    //save
                    defaults.setBool(true, forKey: "hasLogin")
                    defaults.setObject(sessionKey, forKey: "sessionKey")
                    defaults.setObject(account, forKey: "username")
                    defaults.setObject(password, forKey: "password")
                    defaults.setObject(idCard, forKey: "IDCard")
                    
                    //hudView
                    self.hudView.hideAnimated(self.view, animated: false)
                    let okView = OKView.hudInView(self.view, animated: false)
                    okView.text = "登录成功"
                    afterDelay(1.0){
                        okView.hideAnimated(self.view, animated: false)
                        NSNotificationCenter.defaultCenter().postNotificationName("didReceiveShipsData", object: ships)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                } else {
                    //hudView
                    self.hudView.hideAnimated(self.view, animated: false)
                    let okView = OKView.hudInView(self.view, animated: false)
                    if code == 2 {
                        okView.text = "密码错误"
                    } else if code == 1 {
                        okView.text = "用户不存在"
                    }
                    okView.imagename = "error"
                    afterDelay(1.0){
                        okView.hideAnimated(self.view, animated: false)
                    }
                }
                
                
                
                
                
                
            case .Failure(let error):
                self.hudView.hideAnimated(self.view, animated: true)
                print(error)
            }
        })
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if textField == accountTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
}
