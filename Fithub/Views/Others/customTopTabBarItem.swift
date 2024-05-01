//
//  customTopTabBarItem.swift
//  Fithub
//
//  Created by ชลิศา ธรรมราช on 2/5/2567 BE.
//

import SwiftUI

struct customTopTabBarItem: View {
    @Binding var selectedTab: Int
    var index: Int
    var label: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = index
            }
        }) {
            VStack {
                GeometryReader { geo in
                    VStack(alignment: .center){
                        if (selectedTab == index){
                            Text(label)
                                .font(.system(size: 15))
                                .bold()
                                .padding(.bottom,3)
                                .overlay(
                                    Rectangle()
                                        .frame(width: geo.size.width-10, height: 3)
                                        .foregroundColor(.blue),
                                    alignment: .bottom
                                )
                        } else {
                            Text(label)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundColor((selectedTab == index) ? Color(UIColor(hex: "#2B70E4")) : Color.white )
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, maxHeight: 30)
        }
    }
}

#Preview {
    customTopTabBarItem(
        selectedTab: .constant(0),
        index: 0,
        label: "person")
}
