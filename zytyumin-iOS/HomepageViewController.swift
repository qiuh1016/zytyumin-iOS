//
//  ViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import SDCycleScrollView

class HomepageViewController: UIViewController, SDCycleScrollViewDelegate {
    
    let imageUrls = [
        "http://www.cnfm.gov.cn/tpxwsyyzw/201607/W020160729535413736589.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/W020160613350121243228.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/W020160607311179962227.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201605/W020160530525181788332.jpg",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/W020160629399731306479.jpg"
    ]
    
    let imageTitles = [
        "学习习近平七一重要讲话加快推进渔业转型升级",
        "于康震：实现有质量的渔业转型升级发展",
        "水生生物增殖放流活动在全国范围同步举行",
        "中国秘鲁举行双边渔业会谈",
        "渔业渔政管理局开展定点扶贫村结对帮扶工作"
    ]
    
    let imageWebUrls = [
        "http://www.cnfm.gov.cn/tpxwsyyzw/201607/t20160729_5222942.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160613_5167471.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160607_5163334.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201605/t20160530_5154751.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160629_5190352.htm"
    ]
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonView_0: UIView!
    @IBOutlet weak var buttonView_1: UIView!
    @IBOutlet weak var buttonView_2: UIView!
    @IBOutlet weak var buttonView_3: UIView!
    
    @IBOutlet weak var buttonView_4: UIView!
    @IBOutlet weak var buttonView_5: UIView!
    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initNavigationBar()
        initSDCycleScrollView()
        roundCornerButtonView()
        self.tabBarController?.tabBar.items![2].badgeValue = "1"
        
    }
        
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func initNavigationBar() {
        // navigation bar
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()] //, NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 18.0)!
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func initSDCycleScrollView() {
        // SDCycleScrollView
        cycleScrollView.delegate = self
        cycleScrollView.placeholderImage = UIImage(named: "SDCycleViewDefaultImage")
        cycleScrollView.imageURLStringsGroup = imageUrls
        cycleScrollView.titlesGroup = imageTitles
        cycleScrollView.autoScrollTimeInterval = 8
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight

    }
    
    func roundCornerButtonView() {
        let cornerRadii = CGSizeMake(10, 10)
        makeRoundedCorner(buttonView, corners: [UIRectCorner.AllCorners], cornerRadii: cornerRadii)
        makeRoundedCorner(buttonView_0, corners: [UIRectCorner.TopLeft], cornerRadii: cornerRadii)
        makeRoundedCorner(buttonView_2, corners: [UIRectCorner.TopRight], cornerRadii: cornerRadii)
        makeRoundedCorner(buttonView_3, corners: [UIRectCorner.BottomLeft], cornerRadii: cornerRadii)
        makeRoundedCorner(buttonView_5, corners: [UIRectCorner.BottomRight], cornerRadii: cornerRadii)
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        performSegueWithIdentifier("webViewSegue", sender: index)
        
    }

    @IBAction func button_1_tapped(sender: AnyObject) {
        performSegueWithIdentifier("serviceSegue", sender: 0)
    }

    @IBAction func button_2_tapped(sender: AnyObject) {
        performSegueWithIdentifier("serviceSegue", sender: 1)
    }
    
    @IBAction func button_3_tapped(sender: AnyObject) {
        performSegueWithIdentifier("serviceSegue", sender: 2)
    }
    
    @IBAction func button_4_tapped(sender: AnyObject) {
        performSegueWithIdentifier("serviceSegue", sender: 3)
    }
    
    @IBAction func button_5_tapped(sender: AnyObject) {
        performSegueWithIdentifier("serviceSegue", sender: 4)
    }
    
    @IBAction func button_6_tapped(sender: AnyObject) {
        performSegueWithIdentifier("serviceSegue", sender: 5)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "webViewSegue") {
            let index = sender as! Int
            let vc = segue.destinationViewController as! WebViewController
            vc.urlString = imageWebUrls[index]
        } else if (segue.identifier == "serviceSegue") {
            let vc = segue.destinationViewController as! ServiceViewController
            vc.index = sender as! Int
        }
        
        
    }
}




