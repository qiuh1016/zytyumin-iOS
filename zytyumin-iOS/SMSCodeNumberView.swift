//
//  SMSCodeNumberView.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/12/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class SMSCodeNumberView: UIView {
    
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        label = UILabel(frame: CGRectMake(0, 0, rect.width, 30))
        label.text = ""
        label.font = UIFont(name: textFontName, size: 30)
        label.textColor = UIColor.colorFromRGB(0x666666, alpha: 1)
        label.textAlignment = .Center
        self.addSubview(label)
        
        
        let lineView = UIView(frame: CGRectMake(5, 45, rect.width - 10, 1))
        lineView.backgroundColor = UIColor.colorFromRGB(0x999999, alpha: 1)
        self.addSubview(lineView)
        
    }
    
}