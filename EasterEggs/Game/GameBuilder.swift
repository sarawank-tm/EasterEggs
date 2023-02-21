//
//  GameBuilder.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import Foundation

struct GameBuilder {
    
    static func createGame() -> GameController {
        let store = PersistentStore()
        let controller = GameController(persistentStore: store)
        return controller
    }
}


let easterEggGameManager: GameControllerType = GameBuilder.createGame().initializeGame()
