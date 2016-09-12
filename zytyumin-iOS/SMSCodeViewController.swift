//
//  SMSCodeViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/12/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class SMSCodeViewController: UIViewController {
    
    var headLabel = UILabel()
    
    var codeView1 = SMSCodeNumberView()
    var codeView2 = SMSCodeNumberView()
    var codeView3 = SMSCodeNumberView()
    var codeView4 = SMSCodeNumberView()
    
    @IBOutlet weak var textfield: UITextField!

    var keyboardHeight: CGFloat = 0
    
    let smsCode = "6767"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        textfield.becomeFirstResponder()
        textfield.addTarget(self, action: #selector(SMSCodeViewController.editingChanged), forControlEvents: .EditingChanged)
        textfield.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        initView()
    }
    
    func initView() {
        let screenW = self.view.bounds.width
        let screenH = self.view.bounds.height
        
        let codeViewW = (screenW * 2 / 3) / 4
        
        let space = (screenW - codeViewW * 4) / 9
        let margin: CGFloat = space * 3

        let codeViewY: CGFloat =  (screenH - keyboardHeight) / 2 + codeViewW / 2
        let headLabelY: CGFloat = codeViewY / 2
        
        headLabel = UILabel(frame: CGRectMake(0, headLabelY, screenW, 40))
        headLabel.text = "输入短信验证码"
        headLabel.font = UIFont(name: textFontName, size: 32)
        headLabel.textColor = UIColor.colorFromRGB(0x999999, alpha: 1)
        headLabel.textAlignment = .Center
        self.view.addSubview(headLabel)
        
        codeView1 = SMSCodeNumberView(frame: CGRectMake(margin                            , codeViewY , codeViewW, codeViewW))
        codeView2 = SMSCodeNumberView(frame: CGRectMake(margin + codeViewW + space        , codeViewY , codeViewW, codeViewW))
        codeView3 = SMSCodeNumberView(frame: CGRectMake(margin + codeViewW * 2 + space * 2, codeViewY , codeViewW, codeViewW))
        codeView4 = SMSCodeNumberView(frame: CGRectMake(margin + codeViewW * 3 + space * 3, codeViewY , codeViewW, codeViewW))
        self.view.addSubview(codeView1)
        self.view.addSubview(codeView2)
        self.view.addSubview(codeView3)
        self.view.addSubview(codeView4)
        
        
        
        let resentLabel = UILabel(frame: CGRectMake(0, screenH - keyboardHeight - 50, screenW, 50))
        resentLabel.text = "重新发送"
        resentLabel.font = UIFont(name: textFontName, size: 13)
        resentLabel.textColor = UIColor.colorFromRGB(0x999999, alpha: 1)
        resentLabel.textAlignment = .Center
        
        self.view.addSubview(resentLabel)
    }
    
    func keyboardWillAppear(notification: NSNotification){
        let keyboardInfo = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]
        keyboardHeight = (keyboardInfo?.CGRectValue.size.height)!
        
        initView()
    }
    
    func editingChanged() {
        
        let str = textfield.text! as NSString
        
        if str == "" {
            codeView1.label.text = ""
            codeView2.label.text = ""
            codeView3.label.text = ""
            codeView4.label.text = ""
            return
        }
        
        switch str.length {
        case 1:
            codeView1.label.text = str as String
            codeView2.label.text = ""
            codeView3.label.text = ""
            codeView4.label.text = ""
        case 2:
            codeView1.label.text = (str as String)[0 ..< 1]
            codeView2.label.text = (str as String)[1 ..< 2]
            codeView3.label.text = ""
            codeView4.label.text = ""
        case 3:
            codeView1.label.text = (str as String)[0 ..< 1]
            codeView2.label.text = (str as String)[1 ..< 2]
            codeView3.label.text = (str as String)[2 ..< 3]
            codeView4.label.text = ""
        case 4:
            codeView1.label.text = (str as String)[0 ..< 1]
            codeView2.label.text = (str as String)[1 ..< 2]
            codeView3.label.text = (str as String)[2 ..< 3]
            codeView4.label.text = (str as String)[3 ..< 4]
            
            if str == smsCode {
                print("smsCode correct")
            } else{
                print("smsCode error")
            }
            
        default:
            textfield.text = (str as String)[0 ..< 4]
        }
        
        
    }
    
}

