//
//  OverAllView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 2/5/2567 BE.
//

import SwiftUI

struct OverAllView: View {
    @StateObject private var viewModel = OverAllViewModel()
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack{
             HStack{
                 customTopTabBarItem(selectedTab: $selectedTab, index: 0, label: "Daily")
                 customTopTabBarItem(selectedTab: $selectedTab, index: 1, label: "Weekly")
                 customTopTabBarItem(selectedTab: $selectedTab, index: 2, label: "Monthly")
             }
             .onChange(of: selectedTab) { tag in
                 let period = tag == 0 ? "Daily" : tag == 1 ? "Weekly" : "Monthly"
                 viewModel.fetchData(for: period)
             }
            
            ScrollView{
                switch selectedTab {
                case 0:
                    if let summary = viewModel.dailyActivity{
                        SummaryView(activity: summary, header: true)
                    }
                case 1:
                    if let summary = viewModel.weeklyActivity{
                            
                        SummaryView(activity: summary, header: true)
                    }
                case 2:
                    if let summary = viewModel.monthlyActivity {
                        MonthlyView(data: summary, totalDays: viewModel.totalDaysInMonth)
                    }
                default:
                    Text("Selected tab \(selectedTab)")
                }
            }
         }
        .padding(.horizontal)
        .padding(.bottom,2)
        .onAppear {
            viewModel.fetchData(for: "Daily")
        }
        
//        VStack {
//            Picker("Select Period", selection: $selectedTab) {
//                Text("Daily").tag(0)
//                Text("Weekly").tag(1)
//                Text("Monthly").tag(2)
//            }.pickerStyle(SegmentedPickerStyle())
//            .onChange(of: selectedTab) { tag in
//                let period = tag == 0 ? "Daily" : tag == 1 ? "Weekly" : "Monthly"
//                viewModel.fetchData(for: period)
//            }
//
//            Group {
//                if selectedTab == 0, let summary = viewModel.dailyActivity {
//                    SummaryView(activity: summary)
//                } else if selectedTab == 1, let summary = viewModel.weeklyActivity {
//                    SummaryView(activity: summary)
//                } else if selectedTab == 2, let summary = viewModel.monthlyActivity {
//                    MonthlyView(data: summary, totalDays: viewModel.totalDaysInMonth)
//                } else {
//                    Text("No data available")
//                }
//            }
//            Spacer()
//        }
//        .onAppear {
//            viewModel.fetchData(for: "Daily")  // Fetch daily data initially
//        }
    }
}

struct SummaryView: View {
    var activity: ActivitySummary
    var header: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            if (header) {
                Text("OverAll")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .bold()
            }
            VStack {
                blockContent(label: "Distance:", data: activity.distance / 1000, unit: "km", image: "mappin.and.ellipse")
                blockContent(label: "Time:", data: activity.duration, unit: "seconds", image: "clock.fill")
                blockContent(label: "Calories Burned:", data: activity.caloriesBurned, unit: "cal", image: "flame.fill")
            }
        }
        .padding(.horizontal)
    }
}

struct MonthlyView: View {
    var data: ActivitySummary
    var totalDays: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Average")
                .foregroundColor(.white)
                .font(.system(size: 30))
                .bold()
                .padding(.horizontal)
            
            SummaryView(activity: data, header: false)
//            Text("Total Days Run: \(totalDays)")
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(UIColor(hex: "#48556A")))
                HStack(alignment: .center) {
                    Text("Total Days Run")
                        .font(.system(size: 20))
                    Text("\(totalDays)")
                        .font(.system(size: 40))
                        .bold()
                        .padding()
                    Text("days")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor(hex: "#8399BD")))
                }
                .foregroundColor(.white)
            }
            .padding(.horizontal)
            .frame(width: .infinity, height: 80)
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
    OverAllView()
}
