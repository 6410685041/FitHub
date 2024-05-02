//
//  Challenge.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift  // Import Firestore Codable support

struct Challenge: Codable, Identifiable {
    @DocumentID var id: String?
    let userId: String  // Add userId field
    let type: ChallengeType
    let goalValue: Int   // Change goalValue to Integer
    var currentProgress: Double
    let createDate: Date
    let dueDate: Date
    var isCompleted: Bool {
        return currentProgress >= Double(goalValue)
    }
}

enum ChallengeType: String, Codable {
    case distance
    case time
    case calorie
}
