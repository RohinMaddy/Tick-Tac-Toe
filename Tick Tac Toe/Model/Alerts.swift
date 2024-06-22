//
//  Alerts.swift
//  Tick Tac Toe
//
//  Created by Rohin Madhavan on 20/06/2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Won!!"),
                                    message: Text("You beat the AI!"),
                                    buttonTitle: Text("Yaay!"))
    static let computerWin = AlertItem(title: Text("You Lost!!"),
                                       message: Text("The AI is too smart for you!"),
                                       buttonTitle: Text("Try again?"))
    static let draw = AlertItem(title: Text("Its a Draw!!"),
                                message: Text("Challenge the AI again?"),
                                buttonTitle: Text("Lets go!"))
}
