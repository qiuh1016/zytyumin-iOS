//
//  MapViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController, BMKMapViewDelegate {
    
    var bMKMapView: BMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initMapView()
        setAnnotation(title: "Ningbo", subtitle: nil, latitude: 30, longitude: 122.02, type: .Point)
        setAnnotation(title: "Zhoushan", subtitle: "沈家门", latitude: 30, longitude: 122.01, type: .End)
        setAnnotation(title: "Zhoushan1", subtitle: "沈家门1", latitude: 30, longitude: 122.03, type: .Start)
    }
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
    }
    
    func initMapView() {
        bMKMapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 49))
        bMKMapView.showMapScaleBar = true
        bMKMapView.rotateEnabled = false //关闭旋转
        bMKMapView.overlookEnabled = false //关闭俯视
        bMKMapView.delegate = self
        self.view.addSubview(bMKMapView!)
        
        let mapStatus = BMKMapStatus()
        mapStatus.targetGeoPt = CLLocationCoordinate2D(latitude: 30, longitude: 122)
        mapStatus.fLevel = 13
        bMKMapView.setMapStatus(mapStatus)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //bMKMapView.viewWillAppear()
        bMKMapView.delegate = self // 此处记得不用的时候需要置nil，否则影响内存的释放
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //bMKMapView.viewWillDisappear()
        bMKMapView.delegate = nil // 不用时，置nil
    }

    
    func setAnnotation(title title: String, subtitle: String?, latitude: Double, longitude: Double, type: MyAnnotationType?) {
        let annotation = MyAnnotation()
        annotation.title = title
        if subtitle != nil {
            annotation.subtitle = subtitle
        }
        if type != nil {
            annotation.type = type!
        }
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        bMKMapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        if annotation.isKindOfClass(MyAnnotation) {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("point");
            view = BMKAnnotationView(annotation: annotation, reuseIdentifier: "point");
            view.centerOffset = CGPointMake(0, -(view!.frame.size.height * 0.5));
            view.canShowCallout = true;
            
            let myAnnotation = annotation as! MyAnnotation
            switch myAnnotation.type {
            case .Start:
                view.image = UIImage(named: "map_icon_start");
            case .End:
                view.image = UIImage(named: "map_icon_end");
            case .Point:
                view.image = UIImage(named: "map_icon_point");
            }
            
            return view
        }
        
        return nil
    
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        print(view.annotation.title!())
    }
    
    
}


















