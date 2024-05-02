//
//  ProfileViewModel.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 2/5/2567 BE.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUserData()
    }

    func fetchUserData() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("No user logged in")
            return
        }
        
        db.collection("users")
          .whereField("email", isEqualTo: userEmail)
          .getDocuments { [weak self] (querySnapshot, error) in
              if let error = error {
                  print("Error getting user data: \(error.localizedDescription)")
                  return
              }
              
              self?.user = querySnapshot?.documents.compactMap {
                  try? $0.data(as: User.self)
              }.first
          }
    }
    
    func logOut() {
        if let userId = Auth.auth().currentUser?.uid {
            
            do {
                try Auth.auth().signOut()
                print("User logged out successfully.")
            } catch {
                print("Logout error: \(error)")
            }
        }
    }

    func formattedDate(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}


