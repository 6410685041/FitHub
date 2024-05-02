//
//  SignIn.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
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

                    Button("Login") {
                        viewModel.login()
                    }

                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                }

                VStack {
                    Text("New Around Here")
                    NavigationLink("Create an Account", destination: SignUpView())
                }

                NavigationLink("", destination: MainView(), isActive: $viewModel.isLoggedIn)
            }
        }
    }
}


#Preview {
    SignInView()
}
