//
//  ViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import SDCycleScrollView

private var kGridViewMargin: CGFloat = 10
private let kCornerRadii = CGSize(width: 9, height: 9)


class HomepageViewController: UIViewController, SDCycleScrollViewDelegate {

    let titles = ["业务办理", "记录查询", "电子签证", "法律法规", "业务流程", "待办任务"]
    
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
        "https://view.inews.qq.com/a/NEW201609100159180T",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201607/t20160729_5222942.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160613_5167471.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160607_5163334.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201605/t20160530_5154751.htm",
        "http://www.cnfm.gov.cn/tpxwsyyzw/201606/t20160629_5190352.htm"
    ]

    var cycleScrollView: SDCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initSDCycleScrollView()
        initGridView()
        self.tabBarController?.tabBar.items![2].badgeValue = "1"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()] //, NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 18.0)!
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
    }
    
    func initSDCycleScrollView() {
        cycleScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width * 200 / 375), delegate: self, placeholderImage: UIImage(named: "SDCycleViewDefaultImage"))
        cycleScrollView.imageURLStringsGroup = imageUrls
        cycleScrollView.titlesGroup = imageTitles
        cycleScrollView.autoScrollTimeInterval = 8
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        self.view.addSubview(cycleScrollView)
    }
    
    func initGridView() {
        
        if self.view.frame.height == 480 {
            kGridViewMargin = 20
        }
        let viewWidth = (view.bounds.width - 2 * kGridViewMargin - 4) / 3
        
        let contentGridView = UIView(frame: CGRectMake(kGridViewMargin, cycleScrollView.bounds.height + 0 + kGridViewMargin * 2, viewWidth * 3 + 4, viewWidth * 2 + 3))
        contentGridView.backgroundColor = UIColor.spaceLineColor()
        makeRoundedCorner(contentGridView, corners: .AllCorners, cornerRadii: CGSize(width: 10, height: 10))
        if self.view.frame.height == 480 {
            contentGridView.center.y -= 35
        }
        self.view.addSubview(contentGridView)
        
        let serverGridView = GridView(frame: CGRectMake(1, 1, viewWidth, viewWidth))
        serverGridView.image = UIImage(named: "homepage_service")
        serverGridView.text = titles[0]
        serverGridView.clickCallBack = { () -> () in
            self.performSegueWithIdentifier("serviceSegue", sender: 0)
        }
        makeRoundedCorner(serverGridView, corners: .TopLeft, cornerRadii: kCornerRadii)
        contentGridView.addSubview(serverGridView)
        
        let recordGridView = GridView(frame: CGRectMake(2 + viewWidth, 1, viewWidth, viewWidth))
        recordGridView.image = UIImage(named: "homepage_record")
        recordGridView.text = titles[1]
        recordGridView.clickCallBack = { () -> () in
            self.performSegueWithIdentifier("serviceSegue", sender: 1)
        }
        contentGridView.addSubview(recordGridView)
        
        let visaGridView = GridView(frame: CGRectMake(3 + 2 * viewWidth, 1, viewWidth, viewWidth))
        visaGridView.image = UIImage(named: "homepage_visa")
        visaGridView.text = titles[2]
        visaGridView.clickCallBack = { () -> () in
            self.performSegueWithIdentifier("serviceSegue", sender: 2)
        }
        makeRoundedCorner(visaGridView, corners: .TopRight, cornerRadii: kCornerRadii)
        contentGridView.addSubview(visaGridView)
        
        let lawGridView = GridView(frame: CGRectMake(1, 2 + viewWidth, viewWidth, viewWidth))
        lawGridView.image = UIImage(named: "homepage_law")
        lawGridView.text = titles[3]
        lawGridView.clickCallBack = { () -> () in
            self.performSegueWithIdentifier("serviceSegue", sender: 3)
        }
        makeRoundedCorner(lawGridView, corners: .BottomLeft, cornerRadii: kCornerRadii)
        contentGridView.addSubview(lawGridView)
        
        let processGridView = GridView(frame: CGRectMake(2 + viewWidth, 2 + viewWidth, viewWidth, viewWidth))
        processGridView.image = UIImage(named: "homepage_process")
        processGridView.text = titles[4]
        processGridView.clickCallBack = { () -> () in
            self.performSegueWithIdentifier("serviceSegue", sender: 4)
        }
        contentGridView.addSubview(processGridView)
        
        let todoGridView = GridView(frame: CGRectMake(3 + 2 * viewWidth, 2 + viewWidth, viewWidth, viewWidth))
        todoGridView.image = UIImage(named: "homepage_service")
        todoGridView.text = titles[5]
        todoGridView.clickCallBack = { () -> () in
            self.performSegueWithIdentifier("serviceSegue", sender: 5)
        }
        makeRoundedCorner(todoGridView, corners: .BottomRight, cornerRadii: kCornerRadii)
        contentGridView.addSubview(todoGridView)
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        let vc = WebViewController()
        vc.urlString = imageWebUrls[index]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.showViewController(vc, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "serviceSegue") {
            let vc = segue.destinationViewController as! ServiceViewController
            vc.index = sender as! Int
        }
    }
}




