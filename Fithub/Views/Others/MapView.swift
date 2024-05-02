//
//  MapView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager  // Correctly observing the location manager

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        updateMapRegion(mapView, to: locationManager.location)

        if let userPath = locationManager.userPath {
            updateUserPath(mapView, with: userPath)
        }
    }

    private func updateMapRegion(_ mapView: MKMapView, to location: CLLocationCoordinate2D?) {
        guard let location = location else { return }
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

    private func updateUserPath(_ mapView: MKMapView, with userPath: MKPolyline) {
        if !mapView.overlays.contains(where: { $0 as? MKPolyline == userPath }) {
            mapView.addOverlay(userPath)
        }
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



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationManager: LocationManager())
    }
}
