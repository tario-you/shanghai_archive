//
//  DemoViewController.swift
//  test4
//
//  Created by Tario You on 2023/7/22.
//

import ARKit
import SceneKit
import UIKit
import AVKit
import AVFoundation
import MapKit

class DemoViewController1: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        addLocationToMap(latitude: 31.22045, longitude: 121.48495)
        
        mapView.delegate = self
       
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func addLocationToMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
        centerMapOnLocation(locationCoordinate)
    }
    
    private func centerMapOnLocation(_ coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView.setRegion(region, animated: true)
    }
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .left{
            performSegue(withIdentifier: "left", sender: self)
        }
    }
}

