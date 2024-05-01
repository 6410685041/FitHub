//
//  HomepageView.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import SwiftUI

struct HomepageView: View {
    var body: some View {
        VStack {
            // Header
            HStack{
                Text("FitHub")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .bold()
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bell.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }.padding(.trailing)
                Button {
                    
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                }
            }.padding(.horizontal, 30)
            
            OverAllView()
            Spacer()
        }.padding(.top)
    }
}

#Preview {
    HomepageView()
}
