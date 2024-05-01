//
//  OverAllView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 2/5/2567 BE.
//

import SwiftUI

struct OverAllView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack{
            HStack{
                customTopTabBarItem(selectedTab: $selectedTab, index: 0, label: "Daily")
                customTopTabBarItem(selectedTab: $selectedTab, index: 1, label: "Weekly")
                customTopTabBarItem(selectedTab: $selectedTab, index: 2, label: "Monthly")
                customTopTabBarItem(selectedTab: $selectedTab, index: 3, label: "Yearly")
            }
            
            switch selectedTab {
            case 0:
                DailyView()
            case 1:
                WeeklyView()
            case 2:
                MonthlyView()
            case 3:
                YearlyView()
            default:
                Text("Selected tab \(selectedTab)")
            }
        }.padding(.horizontal)
    }
    
    
}

struct DailyView: View {
    var body: some View {
        Text("Daily Data")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue.opacity(0.3))
    }
}

struct WeeklyView: View {
    var body: some View {
        Text("Weekly Data")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green.opacity(0.3))
    }
}

struct MonthlyView: View {
    var body: some View {
        Text("Monthly Data")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red.opacity(0.3))
    }
}

struct YearlyView: View {
    var body: some View {
        Text("Yearly Data")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow.opacity(0.3))
    }
}


#Preview {
    OverAllView()
}
