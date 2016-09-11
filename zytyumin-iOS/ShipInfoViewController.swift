//
//  ShipInfoViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/11/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import UIKit

class ShipInfoViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ShipInfoViewController.close(_:)))
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
    }
    
    func initView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        routeButton.layer.cornerRadius = 10
        routeButton.layer.masksToBounds = true
        
        detailButton.layer.cornerRadius = 10
        detailButton.layer.masksToBounds = true
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func routeButtonTapped(sender: AnyObject) {
        print("routeButtonTapped")
    }
    @IBAction func detailButtonTapped(sender: AnyObject) {
        print("detailButtonTapped")
    }
    
}

extension ShipInfoViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimationController()
    }
}

extension ShipInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}





