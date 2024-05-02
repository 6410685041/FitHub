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
    @StateObject private var challengeViewModel = ChallengeViewModel()
    @StateObject private var viewModel: ActivityViewModel
    
    init(challengeViewModel: ChallengeViewModel) {
        self._viewModel = StateObject(wrappedValue: ActivityViewModel(challengeViewModel: challengeViewModel))
    }

    var body: some View {
        VStack {
            MapView(locationManager: viewModel.locationManager)
                .frame(height: 300)
            if viewModel.isTracking {
                Text("Distance: \(viewModel.totalDistance / 1000, specifier: "%.2f") km")
                Text("Time: \(viewModel.totalDuration.formattedTime())")
            }
            Button(action: {
                viewModel.toggleTracking()
            }) {
                Text(viewModel.isTracking ? "Stop Tracking" : "Start Tracking")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    ActivityView(challengeViewModel: ChallengeViewModel())
}
