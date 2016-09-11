//
//  MyAnnotation.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation

enum MyAnnotationType {
    case Start
    case End
    case Point
}

class MyAnnotation: BMKPointAnnotation {
    
    var type: MyAnnotationType = .Point
    var index: Int?
    
}
