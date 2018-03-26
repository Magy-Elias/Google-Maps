//
//  GoogleMapsViewController.swift
//  GoogleMapsView
//
//  Created by Mickey Goga on 3/25/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit
import GoogleMaps

class WorkDestination: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class GoogleMapsViewController: UIViewController {

    var mapView: GMSMapView?
    
    var currentDestination: WorkDestination?
    
    let destinations = [WorkDestination(name: "Hegaz Square", location: CLLocationCoordinate2DMake(30.111322, 31.345739), zoom: 15),
                        WorkDestination(name: "IoTBlue Old Location", location: CLLocationCoordinate2DMake(30.114274, 31.336055), zoom: 15)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyAYRW180jdZkYN5Rz12hrvxnIJRrFyBMPY")
        
        let camera = GMSCameraPosition.camera(withLatitude: 30.118246, longitude: 31.348887, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(30.118246, 31.348887)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "IoTBlue New Location"
//        marker.snippet = "Cairo"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(next(sender:)))
    }
    
    @objc func next(sender: Any) {
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.index(of: currentDestination!) {
                currentDestination = destinations[index + 1]
            }
        }
        setMapCamera()
    }
    
    private func setMapCamera() {
//        CATransaction.begin()
//        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination!.name
        //            marker.snippet = "Cairo"
        marker.map = mapView
    }
}

