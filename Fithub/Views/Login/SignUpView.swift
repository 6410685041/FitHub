//
//  SignUpView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @State var showSecondPage = false
    
    var body: some View {
        ZStack{
            if (!showSecondPage){
                // first page
                VStack{
                    Image("background2")
                        .ignoresSafeArea(.all)
                    Spacer()
                }
                
                VStack{
                    Spacer()
                        .frame(height: 430)
                    Rectangle()
                        .foregroundColor(Color(UIColor(hex: "#292929")))
                        .rotationEffect(Angle(degrees: 250))
                        .frame(width: 700, height: 700)
                }
                
                VStack{
                    Rectangle()
                        .foregroundColor(Color(UIColor(hex: "#164EAD")))
                        .rotationEffect(Angle(degrees: 250))
                        .frame(width: 40, height: 700)
                    
                    Spacer()
                        .frame(height: 440)
                }
                
                VStack{
                    HStack{
                        Image(systemName: "dumbbell.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(UIColor(hex: "#2B70E4")))
                            .frame(width: 70)
                        Text("FitHub")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                            .bold()
                        Spacer()
                            .frame(width: 80)
                    }
                    Spacer()
                        .frame(height: 650)
                    
                }
                
                VStack {
                    Spacer()
                        .frame(height: 140)
                    Text("Create")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .bold()
                    Text("New Account")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.bottom)
                    
                    VStack {
                        TextField("Email Address", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .background(Color(UIColor(hex: "#8399BD")))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(UIColor(hex: "#8399BD")), lineWidth: 1)
                            )
                            .padding([.horizontal, .bottom])
                        
                        SecureField("Password", text: $viewModel.password)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .background(Color(UIColor(hex: "#8399BD")))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(UIColor(hex: "#8399BD")), lineWidth: 1)
                            )
                            .padding([.horizontal, .bottom])
                        
                        
                        Button{
                            showSecondPage = true
                        } label: {
                            ZStack(alignment: .center){
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                    .frame(width: 200, height: 50)
                                Text("Next")
                                    .foregroundColor(.white)
                            }
                        }
                    } 
                    .padding(.horizontal,190)
                    .padding(.bottom)
                }
            } else {
                // second page
                VStack{
                    Image("background2")
                        .ignoresSafeArea(.all)
                    Spacer()
                }
                
                VStack{
                    Spacer()
                        .frame(height: 100)
                    Rectangle()
                        .foregroundColor(Color(UIColor(hex: "#292929")))
                        .frame(width: .infinity, height: .infinity)
                }
                
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Text("Information")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.bottom)
                    
                    ScrollView{
                        VStack{
                            TextField("Full Name", text: $viewModel.name)
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                .background(Color(UIColor(hex: "#8399BD")))
                                .cornerRadius(25)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(UIColor(hex: "#8399BD")), lineWidth: 1)
                                )
                                .padding([.horizontal, .bottom])
                            
                            HStack{
                                VStack{
                                    Text("Weight")
                                    TextField("Weight", value: $viewModel.weight, formatter: NumberFormatter())
                                        .autocorrectionDisabled()
                                        .autocapitalization(.none)
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                        .background(Color(UIColor(hex: "#8399BD")))
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color(UIColor(hex: "#8399BD")), lineWidth: 1)
                                        )
                                        .padding(.horizontal)
                                }
                                VStack{
                                    Text("Height")
                                    TextField("Height", value: $viewModel.height, formatter: NumberFormatter())
                                        .autocorrectionDisabled()
                                        .autocapitalization(.none)
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                        .background(Color(UIColor(hex: "#8399BD")))
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color(UIColor(hex: "#8399BD")), lineWidth: 1)
                                        )
                                        .padding(.horizontal)
                                }
                            }
                            .foregroundColor(.white)
                            
                            HStack{
                                Text("Gender")
                                    .foregroundColor(.white)
                                Picker("Gender", selection: $viewModel.gender) {
                                    ForEach(Gender.allCases, id: \.self) { gender in
                                        Text(gender.displayName)
                                    }
                                }
                            }
                            
                            Text("Select birthdate")
                                .foregroundColor(.white)
                            DatePicker("Birthdate", selection: $viewModel.birthdate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                            
                        }
                        .padding(.horizontal,70)
                        
                        Button{
                            viewModel.register()
                        } label: {
                            ZStack(alignment: .center){
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                    .frame(width: 200, height: 50)
                                Text("Sign up")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
