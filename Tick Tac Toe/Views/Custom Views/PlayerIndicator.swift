//
//  PlayerIndicator.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 21/06/2024.
//

import SwiftUI

struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(.white)
    }
}
