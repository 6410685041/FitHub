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
            ZStack{
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
                        .frame(height: 200)
                    Text("SIGN IN")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .bold()
                        .padding(.bottom)
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(.white)
                            .padding(.horizontal)
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
                        
                        Text("Password")
                            .foregroundColor(.white)
                            .padding(.horizontal)
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
                    }
                    .padding(.horizontal,190)
                    .padding(.bottom)
                    
                    Button{
                        viewModel.login()
                    } label: {
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                .frame(width: 200, height: 50)
                            Text("Log in")
                                .foregroundColor(.white)
                        }
                    }
                    
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    VStack {
                        NavigationLink("Create an Account", destination: SignUpView())
                    }
                    
                    NavigationLink("", destination: MainView(), isActive: $viewModel.isLoggedIn)
                }
            }
        }
    }
}


#Preview {
    SignInView()
}
