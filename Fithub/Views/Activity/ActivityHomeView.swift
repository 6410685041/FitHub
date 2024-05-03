//
//  ActivityHomeView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 3/5/2567 BE.
//

import SwiftUI

struct ActivityHomeView: View {
    @State private var startActivity = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Activity")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .bold()
            
            Spacer()
            
            VStack(alignment: .center){
                HStack{
                    Button{
                        startActivity = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                .frame(width: 150, height: 150)
                            Text("Running")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .bold()
                        }
                    }
                    
                    Button{
                        startActivity = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                .frame(width: 150, height: 150)
                            Text("Walking")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .bold()
                        }
                    }
                }
                
                HStack{
                    Button{
                        startActivity = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color(UIColor(hex: "#164EAD")))
                                .frame(width: 150, height: 150)
                            Text("Cycling")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .bold()
                        }
                    }
                    
                    //                Button{
                    //                    startActivity = true
                    //                } label: {
                    //                    ZStack{
                    //                        RoundedRectangle(cornerRadius: 20)
                    //                            .foregroundColor(Color(UIColor(hex: "#164EAD")))
                    //                            .frame(width: 200, height: 50)
                    //                        Text("Walking")
                    //                            .foregroundColor(.white)
                    //                    }
                    //                }
                }
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $startActivity) {ActivityView(challengeViewModel: ChallengeViewModel())}
    }
}

#Preview {
    ActivityHomeView()
}
