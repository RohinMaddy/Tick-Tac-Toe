//
//  GameSquareView.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 21/06/2024.
//

import SwiftUI

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    var color: Color
    
    var body: some View {
        Circle()
            .strokeBorder(.white, lineWidth: 3)
            .foregroundStyle(color).opacity(0.8)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}
