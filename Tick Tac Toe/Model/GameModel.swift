//
//  GameModel.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 21/06/2024.
//

import Foundation

enum Player {
    case playerOne, playerTwo, computer
}

enum Difficulty {
    case easy, medium, hard
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .playerOne ? "xmark" : "circle"
    }
}
