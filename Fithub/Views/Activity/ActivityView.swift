//
//  Activity.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI
import MapKit

struct ActivityView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var locationManager = LocationManager()
    @State private var tracking = false

    var body: some View {
        VStack {
            MapView(locationManager: locationManager)
                .frame(height: 300)
            Button(tracking ? "Stop Tracking" : "Start Tracking") {
                tracking.toggle()
                tracking ? locationManager.startTracking() : locationManager.stopTracking()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ActivityView()
}
