//
//  LocationManager.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userPath = MKPolyline()
    @Published var region = MKCoordinateRegion()
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        
        var coordinates = [CLLocationCoordinate2D]()
        let points = userPath.points()
        for i in 0..<userPath.pointCount {
            coordinates.append(points[i].coordinate)
        }
        coordinates.append(latestLocation.coordinate)
        
        userPath = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        if userPath.pointCount == 1 {
            let newRegion = MKCoordinateRegion(center: latestLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            region = newRegion
        }
    }
}
