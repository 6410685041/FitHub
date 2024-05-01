//
//  Activity.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift  // Import necessary for Firestore Codable integration

struct Activity: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore document ID
    var type: String
    var duration: String
    var distance: String
    var caloriesBurned: String
    var date: Date  // Using Date directly for simplicity in Codable

    enum CodingKeys: String, CodingKey {
        case id
        case type = "type"
        case duration = "duration"
        case distance = "distance"
        case caloriesBurned = "caloriesBurned"
        case date = "date"
    }
}
