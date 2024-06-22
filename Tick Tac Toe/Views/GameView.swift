//
//  ContentView.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 20/06/2024.
//

import SwiftUI

struct GameView: View {

    @StateObject private var viewModel = GameViewModel()
    @State private var showIntro = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid (columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem) { item in
                Alert(title: item.title,
                      message: item.message,
                      dismissButton: .default(item.buttonTitle, action: {
                    viewModel.resetGame()
                }))
            }
        }
        .fullScreenCover(isPresented: $showIntro, content: {
            ZStack {
                IntroView()
            }
        })
    }
}

#Preview {
    GameView()
}
