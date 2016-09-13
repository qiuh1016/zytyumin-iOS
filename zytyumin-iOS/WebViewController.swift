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
    var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新闻"
        initWKWebView()
        initProgressView()
        loadURL(urlString)
    }
    
    func initWKWebView() {
        wkWebView = WKWebView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        self.view.addSubview(wkWebView)
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }
    
    func initProgressView() {
        progressView = UIProgressView(frame: CGRectMake(0, 0, self.view.bounds.width, 5))
        progressView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(progressView)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let keyPath = keyPath where keyPath == "estimatedProgress" {
            if wkWebView.estimatedProgress == 1 {
                progressView.hidden = true
            } else {
                progressView.hidden = false
                progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    func loadURL(url: String) {
        let url = NSURL(string: url)
        let urlRequest = NSURLRequest(URL: url!)
        wkWebView.loadRequest(urlRequest)
    }
    
}
