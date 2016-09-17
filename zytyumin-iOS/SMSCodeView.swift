//
//  SMSCodeNumberView.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/12/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class SMSCodeView: UIView {
    
    var label : UILabel!
    
    var text = "" {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        label = UILabel(frame: CGRectMake(0, 0, rect.width, 30))
        label.text = text
        label.font = UIFont(name: smsCodeFontName, size: 32)
        label.textColor = UIColor.mainColor() // UIColor.colorFromRGB(0x666666, alpha: 1)
        label.textAlignment = .Center
        self.addSubview(label)
        
        
        let lineView = UIView(frame: CGRectMake(5, 42, rect.width - 10, 1))
        lineView.backgroundColor = UIColor.colorFromRGB(0x999999, alpha: 1)
        self.addSubview(lineView)
        
    }
    
}
