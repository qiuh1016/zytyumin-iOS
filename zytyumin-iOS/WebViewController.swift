//
//  WebViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var wkWebView :WKWebView!
    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新闻"
        initWKWebView()
        
    }
    
    func initWKWebView() {
        wkWebView = WKWebView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        self.view.addSubview(wkWebView)
        
        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url!)
        wkWebView.loadRequest(urlRequest)
    }
    
}
