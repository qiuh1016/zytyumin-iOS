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
    var polyline: BMKPolyline?
    
    var coords = [CLLocationCoordinate2D]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        
        initMapView()
        
        let ships = (self.tabBarController as! TabBarController).ships
        
        for ship in ships {
            coords.append(ship.coor)
            setAnnotation(ship, type: .Point)
        }
 
        drawMapLine()
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

    
    func setAnnotation(ship: Ship, type: MyAnnotationType) {
        let annotation = MyAnnotation()
        annotation.title = ship.name
        annotation.subtitle = ship.number
        annotation.type = type
        annotation.coordinate = ship.coor
        bMKMapView.addAnnotation(annotation)
    }
    
    func drawMapLine() {
        polyline = BMKPolyline(coordinates: &coords, count: UInt(coords.count))
        bMKMapView.addOverlay(polyline)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        if annotation.isKindOfClass(MyAnnotation) {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("point");
            view = BMKAnnotationView(annotation: annotation, reuseIdentifier: "point");
            let myAnnotation = annotation as! MyAnnotation
            switch myAnnotation.type {
            case .Start:
                view.image = UIImage(named: "map_icon_start");
            case .End:
                view.image = UIImage(named: "map_icon_end");
            case .Point:
                view.image = UIImage(named: "map_icon_point");
            }
            view.centerOffset = CGPointMake(0, -(view!.frame.size.height * 0.5));
            view.canShowCallout = true;
            return view
        }
        
        return nil
    
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        print(view.annotation.title!())
    }
    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if let overlayTemp = overlay as? BMKPolyline {
            let polylineView = BMKPolylineView(overlay: overlay)
            if overlayTemp == polyline {
                polylineView.strokeColor = UIColor.mainColor()
                polylineView.lineWidth = 2
            }
            return polylineView
        }

        return nil
    }

}


















