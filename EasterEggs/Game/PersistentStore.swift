//
//  PersistentStore.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import Foundation


class PersistentStore {
    var savedEggs = [EasterEgg]()
    func selectedGameableViews() -> [GameableView.Type] {
        [
            MainViewController.self,
            SecondViewController.self,
            FourthViewController.self,
            FirstModalController.self
        ]
    }
    
    func saveEggs(eggs: [EasterEgg]) {
       savedEggs = eggs
    }
    
    func retrieveEgg(for id: GameableView.Type) -> EasterEgg? {
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
