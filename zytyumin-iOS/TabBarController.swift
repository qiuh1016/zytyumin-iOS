//
//  TabBarController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var ships = [Ship]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabBarController")
        
        let ship = Ship.init()
        ships.append(ship)
        
        let ship1 = Ship.init()
        ship1.coor = CLLocationCoordinate2DMake(30.01, 122.01)
        ship1.name = "name1"
        ships.append(ship1)
        
        let ship2 = Ship.init()
        ship2.coor = CLLocationCoordinate2DMake(30.02, 122.02)
        ship2.name = "name2"
        ships.append(ship2)
        
        self.tabBar.tintColor = UIColor.tabBarColor()
    }
    
}
