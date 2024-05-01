//
//  SignInViewModel.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password)
    }
}
