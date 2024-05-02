//
//  MainViewModel.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MainViewModel: ObservableObject {
    @Published var user: User?  // Holds the fetched user data
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                if let user = user {
                    self?.fetchUser(userId: user.uid)
                } else {
                    self?.user = nil  // Reset user data if not signed in
                }
            }
        }
    }

    private func fetchUser(userId: String) {
        Firestore.firestore().collection("users").document(userId).getDocument { [weak self] document, error in
            guard let document = document, document.exists else {
                print("No document found: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self?.user = try? document.data(as: User.self)
        }
    }
}

