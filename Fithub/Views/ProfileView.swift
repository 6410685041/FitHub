//
//  ProfileView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 2/5/2567 BE.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
                Text("Gender: \(user.gender.displayName)")
                Text("Weight: \(user.weight, specifier: "%.1f") kg")
                Text("Height: \(user.height, specifier: "%.1f") cm")
                Text("Birthdate: \(viewModel.formattedDate(from: user.birthdate))")
            } else {
                Text("Loading user data...")
            }
            
            Button("Log Out") {viewModel.logOut()}
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}


#Preview {
    ProfileView()
}
