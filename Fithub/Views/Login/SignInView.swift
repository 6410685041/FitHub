//
//  SignIn.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("FitHub")
                
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    Button("Login"){
                        viewModel.login()
                    }
                }
                VStack {
                    Text("New Around Here")
                    NavigationLink("Create an Account", destination: SignUpView())
                }
                
            }
        }

    }
}

#Preview {
    SignInView()
}
