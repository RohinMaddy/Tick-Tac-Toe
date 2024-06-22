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
    @State private var player =  Player.playerOne
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                Button("", systemImage: "house.fill") {
                    showIntro = true
                }
                .frame(width: 40, height: 40)
                .font(.title)
                .foregroundStyle(.cyan)
                
                Spacer()
                LazyVGrid (columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            if viewModel.secondPlayer == .computer {
                                viewModel.processPlayerMove(for: i)
                            } else {
                                viewModel.processPlayerMove(for: i, player: player)
                                player = viewModel.togglePlayer(player: player)
                                print(player)
                            }
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
                IntroView(viewModel: viewModel)
            }
        })
    }
}

#Preview {
    GameView()
}
