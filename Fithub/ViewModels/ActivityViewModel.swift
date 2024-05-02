//
//  ActivityViewModel.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import Combine
import CoreLocation
import MapKit
import FirebaseFirestore
import FirebaseAuth

class ActivityViewModel: ObservableObject {
    @Published var totalDistance: Double = 0 // Distance in meters
    @Published var totalDuration: TimeInterval = 0
    @Published var isTracking: Bool = false
    private var challengeViewModel: ChallengeViewModel
    
    private var db = Firestore.firestore()
    var locationManager = LocationManager()
    private var startTime: Date?
    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()

    init(challengeViewModel: ChallengeViewModel) {
        self.challengeViewModel = challengeViewModel
        setupSubscriptions()
    }

    private func setupSubscriptions() {
        locationManager.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.updateMetrics(locations: locations)
            }
            .store(in: &cancellables)
    }

    private func updateMetrics(locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        if let prevLocation = locations.dropLast().last {
            let distanceThreshold: Double = 10.0 // meters
            let distanceMoved = lastLocation.distance(from: prevLocation)
            if distanceMoved > distanceThreshold {
                totalDistance += distanceMoved
            }
        }
    }

    func toggleTracking() {
        isTracking.toggle()
        if isTracking {
            startTime = Date()
            locationManager.startTracking()
            startTimer()
        } else {
            locationManager.stopTracking()
            stopTimer()
            if let start = startTime {
                totalDuration = Date().timeIntervalSince(start)
                saveActivityData()
                startTime = nil
            }
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            if let startTime = self?.startTime {
                self?.totalDuration = Date().timeIntervalSince(startTime)
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func saveActivityData() {
        guard let startTime = startTime,
              let user = Auth.auth().currentUser else {  // Ensure there is a logged-in user
            print("No user logged in or invalid start time")
            return
        }
        
        let activityData = Activity(
            type: "Running",  // Example type
            duration: totalDuration,
            distance: totalDistance,
            caloriesBurned: calculateCaloriesBurned(distance: totalDistance),
            date: startTime
        )
        
        // Construct the path using the user's UID
        let userActivitiesPath = "users/\(user.uid)/activities"
        
        do {
            try db.collection(userActivitiesPath).document().setData(from: activityData)
            print("Activity data successfully saved for user \(user.email ?? "unknown")")
        } catch let error {
            print("Error saving activity data: \(error.localizedDescription)")
        }
        challengeViewModel.updateChallenge(with: activityData)
    }

    private func calculateCaloriesBurned(distance: Double) -> Double {
        let distanceInKilometers = distance / 1000.0 // Convert meters to kilometers
        return distanceInKilometers * 60 // 60 calories burned per kilometer
    }
}
