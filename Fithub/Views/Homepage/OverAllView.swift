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
        VStack {
            Picker("Select Period", selection: $selectedTab) {
                Text("Daily").tag(0)
                Text("Weekly").tag(1)
                Text("Monthly").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedTab) { tag in
                let period = tag == 0 ? "Daily" : tag == 1 ? "Weekly" : "Monthly"
                viewModel.fetchData(for: period)
            }

            Group {
                if selectedTab == 0, let summary = viewModel.dailyActivity {
                    SummaryView(activity: summary)
                } else if selectedTab == 1, let summary = viewModel.weeklyActivity {
                    SummaryView(activity: summary)
                } else if selectedTab == 2, let summary = viewModel.monthlyActivity {
                    MonthlyView(data: summary, totalDays: viewModel.totalDaysInMonth)
                } else {
                    Text("No data available")
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchData(for: "Daily")  // Fetch daily data initially
        }
    }
}

struct SummaryView: View {
    var activity: ActivitySummary
    
    var body: some View {
        VStack {
            Text("Distance: \(activity.distance / 1000, specifier: "%.2f") km")
            Text("Time: \(activity.duration, specifier: "%.2f") seconds")
            Text("Calories Burned: \(activity.caloriesBurned, specifier: "%.2f")")
        }
    }
}

struct MonthlyView: View {
    var data: ActivitySummary
    var totalDays: Int

    var body: some View {
        VStack {
            SummaryView(activity: data)
            Text("Total Days Run: \(totalDays)")
        }
    }
}

#Preview {
    OverAllView()
}
