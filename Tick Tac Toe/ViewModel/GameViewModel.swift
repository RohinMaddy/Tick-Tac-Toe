//
//  GameViewModel.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 20/06/2024.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    private let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    @Published var moves: [Move?] = Array.init(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var difficulty = Difficulty.medium
    @Published var secondPlayer: Player?
    @Published var playerOneScore = 0
    @Published var playerTwoScore = 0
    
    func processPlayerMove(for position: Int, player: Player? = .playerOne) {
        if isSquareOccupied(in: moves, forIndex: position) { return }
        
        moves[position] = Move(player: player!, boardIndex: position)
        
        if checkWinCondition(for: player!, in: moves) {
            if player == .playerOne{
                alertItem = AlertContext.humanWin
                playerOneScore += 1
            } else {
                alertItem = AlertContext.humanWin
                playerTwoScore += 1
            }
            isGameBoardDisabled = false
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            isGameBoardDisabled = false
            return
        }
        
        if secondPlayer == .computer {
            isGameBoardDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                
                if checkWinCondition(for: .computer, in: moves) {
                    alertItem = AlertContext.computerWin
                    playerTwoScore += 1
                    isGameBoardDisabled = false
                    return
                }
                
                if checkForDraw(in: moves) {
                    alertItem = AlertContext.draw
                    isGameBoardDisabled = false
                    return
                }
                
                isGameBoardDisabled = false
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determineMove(in moves: [Move?], for player: Player) -> Int? {
        let playerMoves = moves.compactMap{ $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(playerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        return nil
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
       
        // Win if possible
        if difficulty == .medium || difficulty == .hard {
            if let position = determineMove(in: moves, for: .computer) {
                return position
            }
        }

        // Block if possible
        if difficulty == .hard {
            if let position = determineMove(in: moves, for: .playerOne) {
                return position
            }
        }
    
        // Middle square
        let centerSquare  = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        // Random position
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let playerMoves = moves.compactMap{ $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array.init(repeating: nil, count: 9)
    }
    
    func togglePlayer(player: Player) -> Player {
        if player == .playerOne {
            return Player.playerTwo
        } else {
            return Player.playerOne
        }
    }
    
    func resetScore() {
        playerOneScore = 0
        playerTwoScore = 0
    }
    
    func getThemeColor() -> Color {
        if secondPlayer == .computer {
            return .red
        } else {
            return .cyan
        }
    }
    func getBackground() -> String {
        if secondPlayer == .computer {
            return "robotBg"
        } else {
            return "playerBg"
        }
    }
}
