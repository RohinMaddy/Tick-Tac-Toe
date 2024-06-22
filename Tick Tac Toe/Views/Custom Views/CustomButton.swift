//
//  CustomButton.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 22/06/2024.
//

import SwiftUI

struct CustomButton: View {
    
    var proxy: GeometryProxy
    var color: Color
    var title: String
    var height: Double
    var action: () -> Void
   
    
    var body: some View {
        Button(title) {
            action()
        }
        .frame(width: proxy.size.width - 30, height: height)
        .foregroundStyle(.white)
        .background(color).opacity(0.8)
        .clipShape(.rect(cornerRadius: 10.0))
        .border(.white, width: 2)
        .font(.title3)
        .fontWeight(.bold)
        .padding()
    }
}
