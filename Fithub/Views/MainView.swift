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
            if viewModel.isSignedIn, let user = viewModel.user {
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
                ActivityView()
            case 2:
                ChallengeView()
            default:
                Text("Selected tab \(selectedTab)")
            }
            
            // Custom tab bar
            VStack{
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 100)
                        .edgesIgnoringSafeArea([.bottom])
                    HStack {
                        customTabBarItem(selectedTab: $selectedTab, index: 0, label: "Home", icon: "house.fill")
                        customTabBarItem(selectedTab: $selectedTab, index: 1, label: "Activity", icon: "clipboard.fill")
                        customTabBarItem(selectedTab: $selectedTab, index: 2, label: "Challenge", icon: "newspaper.fill")
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
