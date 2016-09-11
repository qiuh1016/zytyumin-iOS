//
//  UserViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController {
    
    var lineTexts = ["修改密码", "我的待办", "版本信息"]
    
    var taps = [UITapGestureRecognizer]()
    var selectors = [Selector]()
    
    var loginButton: UIButton!
    var hasLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initNavigationBar()
        initTap()
        initView()
    }
    
    func initTap() {
        selectors.append(#selector(ServiceViewController.tapped1(_:)))
        selectors.append(#selector(ServiceViewController.tapped2(_:)))
        selectors.append(#selector(ServiceViewController.tapped3(_:)))
        
        for selector in selectors {
            let tap = UITapGestureRecognizer(target: self, action: selector)
            taps.append(tap)
        }
        
    }
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
    }
    
    func initView() {
        
        let lineNumber = lineTexts.count
        var lineHeight = 55
        let imageWidth = 21
        let space = 15
        let cornerRadii = CGSizeMake(9, 9)
        
        if self.view.frame.height == 480 {
            lineHeight = 50
        }
        
        view.backgroundColor = UIColor.colorFromRGB(0xEEEEEE, alpha: 1)
        
        //contentView
        let viewWidth = self.view.bounds.width - 20
        let contentView = UIView(frame: CGRectMake(10, 20, viewWidth, CGFloat(lineHeight * lineNumber + lineNumber + 1)))
        contentView.backgroundColor = UIColor.spaceLineColor()
        makeRoundedCorner(contentView, corners: [UIRectCorner.AllCorners], cornerRadii: CGSize(width: 10, height: 10))
        view.addSubview(contentView)
        
        //lineView
        for i in 0 ... lineNumber - 1{
            let lineView = UIView(frame: CGRectMake(1, CGFloat(lineHeight * i + i + 1), viewWidth - 2, CGFloat(lineHeight)))
            lineView.backgroundColor = (i % 2 == 0) ? UIColor.mainLightColor() : UIColor.whiteColor()
            lineView.userInteractionEnabled = true
            lineView.addGestureRecognizer(taps[i])
            
            if lineNumber == 1 {
                makeRoundedCorner(lineView, corners: [UIRectCorner.AllCorners], cornerRadii: cornerRadii)
            } else {
                if i == lineNumber - 1 {
                    makeRoundedCorner(lineView, corners: [UIRectCorner.BottomLeft, .BottomRight], cornerRadii: cornerRadii)
                } else if i == 0 {
                    makeRoundedCorner(lineView, corners: [UIRectCorner.TopLeft, .TopRight], cornerRadii: cornerRadii)
                }
            }
            
            //text
            let label = UILabel(frame: CGRectMake(CGFloat(space), 0, lineView.bounds.width - CGFloat(3 * space) - CGFloat(imageWidth), CGFloat(lineHeight)))
            label.text = lineTexts[i]
            label.textColor = UIColor.textColor()
            label.font = UIFont(name: "Helvetica Neue", size: 16)
            label.backgroundColor = UIColor.clearColor()
            
            //imageView
            let arrawImageView = UIImageView(image: UIImage(named: "setting_arrow_big"))
            arrawImageView.frame = CGRectMake(lineView.bounds.width - CGFloat(space) - CGFloat(imageWidth), CGFloat((lineHeight - imageWidth) / 2), CGFloat(imageWidth), CGFloat(imageWidth))
            arrawImageView.contentMode = .ScaleAspectFit
            
            lineView.addSubview(label)
            lineView.addSubview(arrawImageView)
            contentView.addSubview(lineView)
        }
        
        
        //login Button
        loginButton = UIButton(type: .System)
        loginButton.frame = CGRectMake(10, contentView.frame.maxY + 20, viewWidth, CGFloat(lineHeight + 2))
        loginButton.setTitle("LOG IN", forState: .Normal)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        loginButton.backgroundColor = UIColor.mainColor()
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.addTarget(self, action: #selector(UserViewController.loginButtonTapped(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(loginButton)
    }
    
    func tapped1(sender: UITapGestureRecognizer) {
        print("\(lineTexts[0])")
    }
    
    func tapped2(sender: UITapGestureRecognizer) {
        print("\(lineTexts[1])")
    
    }
    
    func tapped3(sender: UITapGestureRecognizer) {
        print("\(lineTexts[2])")
        
    }
    
    func loginButtonTapped(sender: UIButton) {
        print("login")
        hasLogin = !hasLogin
        loginButton.setTitle(hasLogin ? "LOG OUT" : "LOG IN", forState: .Normal)
        loginButton.backgroundColor = hasLogin ? UIColor.logoutTextColor() : UIColor.mainColor()
        
        
    }
    
}