//
//  OverAllViewModel.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 2/5/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class OverAllViewModel: ObservableObject {
    @Published var dailyActivity: ActivitySummary?
    @Published var weeklyActivity: ActivitySummary?
    @Published var monthlyActivity: ActivitySummary?
    @Published var totalDaysInMonth: Int = 0

    private var db = Firestore.firestore()

    func fetchData(for period: String) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("Error: No user logged in.")
            return
        }

        let now = Date()
        let start: Date
        let calendar = Calendar.current

        switch period {
        case "Daily":
            start = calendar.startOfDay(for: now)
            fetchActivities(start: start, end: now, period: period)
        case "Weekly":
            start = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
            fetchActivities(start: start, end: now, period: period)
        case "Monthly":
            start = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            fetchActivitiesForMonth(start: start, end: now)
        default:
            print("Unsupported period")
        }
    }

    private func fetchActivities(start: Date, end: Date, period: String) {
        let userActivitiesPath = "users/\(Auth.auth().currentUser?.uid ?? "")/activities"
        db.collection(userActivitiesPath)
            .whereField("date", isGreaterThanOrEqualTo: start)
            .whereField("date", isLessThanOrEqualTo: end)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    return
                }
                let activities = snapshot?.documents.compactMap { doc -> Activity? in
                    try? doc.data(as: Activity.self)
                } ?? []
                
                let summary = activities.reduce(ActivitySummary()) { acc, cur in
                    return ActivitySummary(
                        distance: acc.distance + cur.distance,
                        duration: acc.duration + cur.duration,
                        caloriesBurned: acc.caloriesBurned + cur.caloriesBurned
                    )
                }
                
                DispatchQueue.main.async {
                    if period == "Daily" {
                        self.dailyActivity = summary
                    } else {
                        self.weeklyActivity = summary
                    }
                }
            }
    }

    private func fetchActivitiesForMonth(start: Date, end: Date) {
        let userActivitiesPath = "users/\(Auth.auth().currentUser?.uid ?? "")/activities"
        db.collection(userActivitiesPath)
            .whereField("date", isGreaterThanOrEqualTo: start)
            .whereField("date", isLessThanOrEqualTo: end)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    return
                }
                let activities = snapshot?.documents.compactMap { doc -> Activity? in
                    try? doc.data(as: Activity.self)
                } ?? []
                
                let totalDays = Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0 + 1
                self.totalDaysInMonth = totalDays
                let summary = activities.reduce(ActivitySummary()) { acc, cur in
                    return ActivitySummary(
                        distance: acc.distance + cur.distance,
                        duration: acc.duration + cur.duration,
                        caloriesBurned: acc.caloriesBurned + cur.caloriesBurned
                    )
                }

                let avgSummary = ActivitySummary(
                    distance: summary.distance / Double(totalDays),
                    duration: summary.duration / Double(totalDays),
                    caloriesBurned: summary.caloriesBurned / Double(totalDays)
                )
                
                DispatchQueue.main.async {
                    self.monthlyActivity = avgSummary
                }
            }
    }
}

struct ActivitySummary {
    var distance: Double = 0
    var duration: Double = 0
    var caloriesBurned: Double = 0
}
