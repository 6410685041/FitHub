//
//  LocationManager.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import CoreLocation
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locations = [CLLocation]()
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var userPath: MKPolyline?
    @Published var isTracking = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.activityType = .fitness
    }

    func startTracking() {
        isTracking = true
        locations = []
        manager.startUpdatingLocation()
    }
    
    func stopTracking() {
        isTracking = false
        manager.stopUpdatingLocation()
        updateUserPath()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        locations.append(contentsOf: newLocations)
        updateUserPath()
    }
    
    private func updateUserPath() {
        let coordinates = locations.map { $0.coordinate }
        userPath = MKPolyline(coordinates: coordinates, count: coordinates.count)
    }
}

