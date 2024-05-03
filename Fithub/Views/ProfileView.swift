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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .foregroundColor(Color(UIColor(hex: "#6881AB")))
                    .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            VStack{
                if let user = viewModel.user {
                    ZStack{
                        Circle()
                            .frame(width: 150)
                            .foregroundColor(Color.white)
                        
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140)
                            .foregroundColor(Color(UIColor(hex: "#6881AB")))
                    }
                    
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("Full Name")
                            roundedText(text: "\(user.name)", height: 30, width: 200)
                        }
                        VStack(alignment: .leading){
                            Text("Email:")
                            roundedText(text: "\(user.email)", height: 30, width: 200)
                        }
                        HStack{
                            VStack(alignment: .leading){
                                Text("Weight:")
                                roundedText(text: String(format: "%.1f kg", user.weight), height: 30, width: 80)
                            }
                            VStack(alignment: .leading){
                                Text("Height:")
                                roundedText(text: String(format: "%.1f cm", user.height), height: 30, width: 80)
                            }
                        }
                        .padding(.bottom)
                        HStack{
                            Text("Gender:")
                            roundedText(text: "\(user.gender.displayName)", height: 30, width: 200)
                        }
                        .padding(.bottom)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 50)
                    
                    Spacer()
                    
                    Button{
                        viewModel.logOut()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                .frame(width: 200, height: 50)
                            Text("Log out")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom)
                } else {
                    Text("Loading user data...")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrowshape.backward.fill")
                .foregroundColor(.white)
            Text("Back")
                .foregroundColor(.white)
                .font(.headline)
                .bold()
                .padding(.leading, 7)
        })
    }
    
}

private struct roundedText: View {
    var text: String
    var height: Double
    var width: Double
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(UIColor(hex: "#8399BD")))
                .frame(height: height)
            Text(text)
                .foregroundColor(.white)
                .frame(width: width, height: height, alignment: .leading)
        }
    }
}

#Preview {
    ProfileView()
}
