//
//  SignUpViewModel.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var height = 0
    @Published var weight = 0
    @Published var gender = Gender.undefined
    @Published var birthdate = Date()
    
    func register() {
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    private func insertUserRecord(id: String) {
        let newUser = User(
            id: id,
            name: name,
            email: email,
            gender: gender,
            weight: Double(weight),
            height: Double(height),
            birthdate: birthdate.timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        guard password.count >= 6 else {
            return false
        }
        return true
    }
}
