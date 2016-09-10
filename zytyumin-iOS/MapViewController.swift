//
//  MapViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        // navigation bar
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.whiteColor()] 
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
