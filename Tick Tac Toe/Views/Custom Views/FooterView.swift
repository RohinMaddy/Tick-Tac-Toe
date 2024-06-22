//
//  FooterView.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 22/06/2024.
//

import SwiftUI

struct FooterView: View {
    
    @ObservedObject var viewModel: GameViewModel
    var footerColor: Color
    
    var body: some View {
        HStack {
            VStack {
                Text("X Score")
                Text("\(viewModel.playerOneScore)")
            }
            Spacer()
            Button("Clear") {
                viewModel.resetScore()
            }
            .font(.title2)
            Spacer()
            VStack {
                Text("O Score")
                Text("\(viewModel.playerTwoScore)")
            }
        }
        .foregroundStyle(.white)
        .padding()
        .font(.subheadline)
        .fontWeight(.bold)
        .background(footerColor)
        .clipShape(.rect(cornerRadius: 10))
    }
}
