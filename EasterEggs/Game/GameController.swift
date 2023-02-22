//
//  GameController.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import Foundation

class GameController: GameControllerType {
    
    let persistentStore: PersistentStore
    
    init(persistentStore: PersistentStore) {
        self.persistentStore = persistentStore
    }
    
    func isEligible(view: GameableView.Type) -> Bool {
        let eligibleViews = persistentStore.selectedGameableViews()
        
        return eligibleViews.contains { view == $0 }
    }
    
    func retrieveEgg(for view: GameableView.Type) -> EasterEgg? {
        persistentStore.retrieveEgg(for: view)
    }
    
    func eggTapped(_ egg: EasterEgg) {
        
        var mutableEgg = egg
        mutableEgg.setDiscovered()
        
        if persistentStore.updateEgg(egg: mutableEgg) {
          //SUCCESS
        } else {
            //false
        }   
    }

    func initializeGame() -> Self {
        // 1. Randomly select screens (randomize) //Fetch
        let eligibleViews = persistentStore.selectedGameableViews()
        var eggs: [EasterEgg] = []
        
        for id in eligibleViews {
            let egg = EasterEgg(id: id, isDiscovered: false)
            eggs.append(egg)
        }
        
        persistentStore.saveEggs(eggs: eggs)
        
        return self
    }
    
    func retrieveEggs() -> [EasterEgg] {
        persistentStore.savedEggs
    }
}

protocol GameControllerType {
    
    func retrieveEgg(for view: GameableView.Type) -> EasterEgg?
    func eggTapped(_ egg: EasterEgg)
    func retrieveEggs() -> [EasterEgg]
}

struct EasterEgg {
    let id: GameableView.Type // Issue is if there are duplicate screen occurrences? This might fail.
    private(set) var isDiscovered: Bool
    
    mutating func setDiscovered() {
        isDiscovered = true
    }
    
    init(id: GameableView.Type, isDiscovered: Bool) {
        self.id = id
        self.isDiscovered = isDiscovered
    }
}
