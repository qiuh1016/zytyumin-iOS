//
//  TabBarController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TabBarController: UITabBarController {
    
    var ships = [Ship]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor.tabBarColor()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TabBarController.didReceiveShipsData(_:)), name: "didReceiveShipsData", object: nil)
        
        checkUpdate()
        
        self.tabBar.items![2].badgeValue = "1"
    }
    
    func didReceiveShipsData(notification: NSNotification) {
        self.ships = (notification.object as? [Ship])!
    }
    
    func checkUpdate() {
        
        let okHandler = { (action: UIAlertAction!) -> Void in
            let url = NSURL(string: appViewUrl)
            if UIApplication.sharedApplication().canOpenURL(url!) {
                UIApplication.sharedApplication().openURL(url!)
            } else {
                print("cannot open app store ")
            }
        }
        
        Alamofire.request(.POST, checkUpdateUrl, parameters: ["id": 1071530431]).responseJSON { response in
            switch response.result {
            case .Success(let value):
                let results = JSON(value)["results"].arrayValue
                let version = results[0]["version"].stringValue
                let description = results[0]["description"].stringValue
                if self.compareVersionsFromAppStore(version) {
                    alertView("\(version)版本已发布", message: "更新内容:\n\(description)", okActionTitle: "升级", cancleActionTitle: "取消", okHandler: okHandler, viewController: self)
                    print("need update: serverVersion: \(version)")
                } else{
                    print("no update: serverVersion: \(version)")
                }
            case .Failure(let error):
                print("check update error: \n\(error)")
            }
        }
        
    }
    
    func compareVersionsFromAppStore(AppStoreVersion: String) -> Bool {
        
        let AppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        if AppVersion == nil {
            return false
        }
        
        var aArray = AppStoreVersion.componentsSeparatedByString(".")
        var bArray = AppVersion!.componentsSeparatedByString(".")
        
        while aArray.count < bArray.count { aArray.append("0") }
        while aArray.count > bArray.count { bArray.append("0") }
        
        for i in 0 ... aArray.count - 1 {
            if Int(aArray[i]) > Int(bArray[i]) {
                return true
            }
        }
        
        return false
        
    }
    
}
