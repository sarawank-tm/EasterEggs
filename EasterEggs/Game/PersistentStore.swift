//
//  PersistentStore.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import Foundation


class PersistentStore {
    var savedEggs = [EasterEgg]()
    func selectedGameableViews() -> [GameableViewId] {
        [
            .mainView,
            .secondView,
            .fourthView,
            .firstModal
        ]
    }
    
    func saveEggs(eggs: [EasterEgg]) {
       savedEggs = eggs
    }
    
    func retrieveEgg(for id: GameableViewId) -> EasterEgg? {
        return savedEggs.first { id == $0.id }
    }
    
    func updateEgg(egg: EasterEgg) -> Bool {
        if let firstIndex = savedEggs.firstIndex(where: {$0.id == egg.id}) {
            savedEggs.remove(at: firstIndex)
            savedEggs.append(egg)
            return true
        }
        return false
    }
}
