//
//  ContentView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var selectedTab: Int = 0
    
    var body: some View {
            Group {
                if let user = viewModel.user {
                    accountView(for: user)
                } else {
                    SignInView()
                }
            }
        }
    
    @ViewBuilder
    private func accountView(for user: User) -> some View {
        VStack(spacing: 0) {
            // Content views
            switch selectedTab {
            case 0:
                HomepageView()
            case 1:
                ActivityView(challengeViewModel: ChallengeViewModel())
            case 2:
                ChallengeView()
            default:
                Text("Selected tab \(selectedTab)")
            }
            
            // Custom tab bar
            VStack{
                ZStack{
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .foregroundColor(Color(UIColor(hex: "#343434")))
                        .frame(width: .infinity, height: 100)
                    HStack {
                        customTabBarItem(selectedTab: $selectedTab, index: 0, label: "Home", icon: "house.fill")
                        customTabBarItem(selectedTab: $selectedTab, index: 1, label: "Activity", icon: "figure.run")
                        customTabBarItem(selectedTab: $selectedTab, index: 2, label: "Challenge", icon: "flag.2.crossed.fill")
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
