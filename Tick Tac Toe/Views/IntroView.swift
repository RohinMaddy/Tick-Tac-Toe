//
//  IntroView.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 21/06/2024.
//

import SwiftUI

struct IntroView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var didSelectComputer = false
    @State private var settingsDetent = PresentationDetent.medium
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                CustomButton(proxy: geometry, color: .cyan, title: "VS Player", height: 80) {
                    viewModel.secondPlayer = .playerTwo
                    dismiss()
                }
                
                CustomButton(proxy: geometry, color: .red, title: " VS Computer", height: 80) {
                    didSelectComputer.toggle()
                }
                .sheet(isPresented: $didSelectComputer, content: {
                    VStack {
                        Text("Choose Computer Difficulty")
                            .font(.title2)
                            .bold()
                        
                        CustomButton(proxy: geometry, color: .green, title: "Easy", height: 60) {
                            viewModel.difficulty = .easy
                            viewModel.secondPlayer = .computer
                            dismiss()
                        }
                        
                        CustomButton(proxy: geometry, color: .yellow, title: "Medium", height: 60) {
                            viewModel.difficulty = .medium
                            viewModel.secondPlayer = .computer
                            dismiss()
                        }
                        
                        CustomButton(proxy: geometry, color: .red, title: "Hard", height: 60) {
                            viewModel.difficulty = .hard
                            viewModel.secondPlayer = .computer
                            dismiss()
                        }
                    }
                    .presentationDetents(
                        [.medium, .large],
                        selection: $settingsDetent
                     )
                })
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    IntroView()
//}
