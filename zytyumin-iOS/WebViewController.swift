//
//  WebViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        self.navigationController?.navigationBar.barTintColor = mainColor
//        self.navigationController?.navigationBar.titleTextAttributes =
//            [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 18.0)!]
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let url = NSURL(string: urlString) //"https://view.inews.qq.com/a/NEW2016090904893404"
        let urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)
    }

    
}
