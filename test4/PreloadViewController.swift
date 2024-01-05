//
//  PreloadViewController.swift
//  test4
//
//  Created by Tario You on 2023/7/27.
//


import ARKit
import SceneKit
import UIKit
import AVKit
import AVFoundation
import MapKit

class PreloadViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        addLocationToMap(latitude: 31.22045, longitude: 121.48495)
        
        mapView.delegate = self
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
}
