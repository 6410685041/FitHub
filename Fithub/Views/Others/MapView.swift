//
//  MapView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if !mapView.overlays.contains(where: { $0 as? MKPolyline == locationManager.userPath }) {
            mapView.addOverlay(locationManager.userPath)
        }
        mapView.setRegion(locationManager.region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

struct ExampleMapView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
        MapView(locationManager: locationManager)
            .frame(height: 300)
    }
}

struct ExampleMapView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleMapView()
    }
}
