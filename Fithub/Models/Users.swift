//
//  Users.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    var id: String?
    var name: String
    let email: String
    var gender: Gender
    var weight: Double
    var height: Double
    var birthdate: TimeInterval
    
}

enum Gender: String, Codable, CaseIterable {
    case male = "male"
    case female = "female"
    case lgbt = "lgbt"
    case undefined = "undefined"
    
    var displayName: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .lgbt:
            return "LGBT"
        case .undefined:
            return "Undefined"
        }
    }
}
