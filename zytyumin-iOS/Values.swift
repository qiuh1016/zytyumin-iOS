//
//  values.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

let textFontName = "Helvetica Neue"

extension UIColor {
    class func mainColor() -> UIColor {
        return UIColor.colorFromRGB(0x157CFB, alpha: 1) //
    }
    
    class func mainLightColor() -> UIColor {
        return UIColor.colorFromRGB(0xddedfd, alpha: 1) //
    }
    
    class func textColor() -> UIColor {
        return UIColor.colorFromRGB(0x555555, alpha: 1)  // 0x333333
    }
    
    class func logoutTextColor() -> UIColor {
        return UIColor.colorFromRGB(0xfa2222, alpha: 1)
    }
    
    class func spaceLineColor() -> UIColor {
        return UIColor.colorFromRGB(0xcccccc, alpha: 0.5)
    }
    
    class func lightGreenColor() -> UIColor {
        return UIColor.colorFromRGB(0x50D2C2, alpha: 1)
    }
    
}
