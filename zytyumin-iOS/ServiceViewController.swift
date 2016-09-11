//
//  ServerViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    
    var index : Int!
    var lineNumbers = [3, 5, 4, 1, 3, 4]
    var titles = ["业务办理", "记录查询", "电子签证", "法律法规", "业务流程", "待办任务"]
    var lineTexts = [
        ["渔船检验申报", "图纸审查申报", "图纸审查申报"],
        ["投保记录查询", "投保记录查询", "交易记录查询", "检验记录查询", "审图记录查询"],
        ["出港确认", "进港确认", "打卡记录", "出海记录"],
        ["法律法规"],
        ["渔船检验业务流程", "渔船登记业务流程", "捕捞许可业务流程"],
        ["审图意见书", "报检单", "整改意见书", "检验记录"]
    ]
    
    var taps = [UITapGestureRecognizer]()
    var selectors = [Selector]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titles[index]
        initTap()
        initView()
    }

    func initTap() {
        selectors.append(#selector(ServiceViewController.tapped1(_:)))
        selectors.append(#selector(ServiceViewController.tapped2(_:)))
        selectors.append(#selector(ServiceViewController.tapped3(_:)))
        selectors.append(#selector(ServiceViewController.tapped4(_:)))
        selectors.append(#selector(ServiceViewController.tapped5(_:)))
        
        for selector in selectors {
            let tap = UITapGestureRecognizer(target: self, action: selector)
            taps.append(tap)
        }

    }
    
    func initView() {
        
        let lineNumber = lineTexts[index].count
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
        
        if lineNumber == 0 {
            return
        }
        
        
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
            label.text = lineTexts[index][i]
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
        
        
        
    }

    
    func tapped1(sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][0])")
        
    }
    
    func tapped2(sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][1])")
        
    }
    
    func tapped3(sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][2])")
        
    }
    
    func tapped4(sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][3])")
        
    }
    
    func tapped5(sender: UITapGestureRecognizer) {
        print("\(lineTexts[index][4])")
        
    }
    
    
    

    
}
