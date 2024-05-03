//
//  Activity.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI
import MapKit

struct ActivityView: View {
    @StateObject private var challengeViewModel = ChallengeViewModel()
    @StateObject private var viewModel: ActivityViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(challengeViewModel: ChallengeViewModel) {
        self._viewModel = StateObject(wrappedValue: ActivityViewModel(challengeViewModel: challengeViewModel))
    }

    var body: some View {
        NavigationView {
            VStack {
                MapView(locationManager: viewModel.locationManager)
                    .frame(height: 300)
                if viewModel.isTracking {
                    blockContent(label: "Distance:", data: viewModel.totalDistance / 1000, unit: "km", image: "mappin.and.ellipse")
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(UIColor(hex: "#48556A")))
                        VStack(alignment: .leading) {
                            HStack{
                                Text("Time:")
                                    .font(.system(size: 20))
                                Spacer()
                                Image(systemName: "clock.fill")
                                    .foregroundColor(Color(UIColor(hex: "#8399BD")))

                            }
                            Text("\(viewModel.totalDuration.formattedTime())")
                                .font(.system(size: 40))
                                .bold()
                        }
                        .padding(.horizontal,30)
                        .foregroundColor(.white)
                    }
                    .frame(width: .infinity, height: 150)
                }
                Button(action: {
                    viewModel.toggleTracking()
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(UIColor(hex: "#164EAD")))
                            .frame(width: 200, height: 50)
                        Text(viewModel.isTracking ? "Stop Tracking" : "Start Tracking")
                            .foregroundColor(.white)
                    }
                }
                if (!viewModel.isTracking) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                .frame(width: 200, height: 50)
                            Text("End")
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor(hex: "#292929")))
//            .navigationBarBackButtonHidden(true)
        }
    }
}

private struct blockContent: View {
    var label: String
    var data: Double
    var unit: String
    var image: String
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor(hex: "#48556A")))
            VStack(alignment: .leading) {
                HStack{
                    Text(label)
                        .font(.system(size: 20))
                    Spacer()
                    Image(systemName: image)
                        .foregroundColor(Color(UIColor(hex: "#8399BD")))

                }
                Text(String(format: "%.2f", data))
                    .font(.system(size: 40))
                    .bold()
                Text(unit)
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor(hex: "#8399BD")))
            }
            .padding(.horizontal,30)
            .foregroundColor(.white)
        }
        .frame(width: .infinity, height: 150)
    }
}

#Preview {
    ActivityView(challengeViewModel: ChallengeViewModel())
}
