//
//  SignUpView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Text("Register")
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Weight", value: $viewModel.weight, formatter: NumberFormatter())
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Height", value: $viewModel.height, formatter: NumberFormatter())
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Text("Gender")
                Picker("Gender", selection: $viewModel.gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.displayName)
                    }
                }
                
                DatePicker("Birthdate", selection: $viewModel.birthdate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button("Create Account"){
                    viewModel.register()
                }
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

#Preview {
    SignUpView()
}
