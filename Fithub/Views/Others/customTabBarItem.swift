//
//  customTabBarItem.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 1/5/2567 BE.
//

import Foundation

import SwiftUI

struct customTabBarItem: View {
    @Binding var selectedTab: Int
    var index: Int
    var label: String
    var icon: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = index
            }
        }) {
            VStack {
                GeometryReader { geo in
                    ZStack{
                        VStack(alignment: .center){
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .padding(.bottom, 2)
                            if (selectedTab == index){
                                Text(label)
                                    .font(.system(size: 10))
                                    .bold()
                            } else {
                                Text(label)
                                    .font(.system(size: 10))
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor((selectedTab == index) ? Color(UIColor(hex: "#2B70E4")) : Color.white )
                    }
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, maxHeight: 90)
        }
    }
}

#Preview {
    customTabBarItem(
        selectedTab: .constant(0),
        index: 0,
        label: "label",
        icon: "person")
}
