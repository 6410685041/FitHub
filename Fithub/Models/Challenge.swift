//
//  Challenge.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift  // Import Firestore Codable support

struct Challenge: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore document ID
    var name: String
    var description: String
    var participants: Int
    var startDate: Date
    var endDate: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case participants
        case startDate
        case endDate
    }
}
