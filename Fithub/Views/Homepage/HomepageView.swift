//
//  HomepageView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct HomepageView: View {
    @State private var showProfile = false  // State to control navigation

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("FitHub")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .bold()
                    Spacer()
                    
//                    Button {
//                        // Action for notifications, if needed
//                    } label: {
//                        Image(systemName: "bell.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 30)
//                    }.padding(.trailing)
                    
                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                    }
                }.padding(.horizontal, 30)

                OverAllView()
                Spacer()
            }
            .padding(.top)
            .background(Color(UIColor(hex: "#292929")))
//            .fullScreenCover(isPresented: $showProfile) {ProfileView()}
            .background(NavigationLink(destination: ProfileView().background(Color(UIColor(hex: "#292929"))), isActive: $showProfile) {
                EmptyView()
            })
        }
    }
}


#Preview {
    HomepageView()
}
