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
    
    func retrieveEgg(for view: GameableViewId) -> EasterEgg? {
        print(view.self)
        return persistentStore.retrieveEgg(for: view)
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
        
//        let encoded = try? JSONEncoder().encode(eggs[0])
//        let encodedString = String(data: encoded!, encoding: .utf8)
//        print("ENCODED:: \(encodedString)")
//        let decoded = try? JSONDecoder().decode(EasterEgg.self, from: encoded!)
//        print("DECODED:: \(decoded)")
//        
        persistentStore.saveEggs(eggs: eggs)
        
        return self
    }
    
    func retrieveEggs() -> [EasterEgg] {
        persistentStore.savedEggs
    }
    
    func eggTapped(withId id: GameableViewId) {
        var egg = retrieveEgg(for: id)
        egg?.setDiscovered()
        
        if let egg = egg,
           persistentStore.updateEgg(egg: egg) {
            //SuCCESS
        } else {
            //FAILED
        }
    }
}

protocol GameControllerType {
    
    func retrieveEgg(for view: GameableViewId) -> EasterEgg?
    func eggTapped(_ egg: EasterEgg)
    func retrieveEggs() -> [EasterEgg]
    func eggTapped(withId id: GameableViewId)
}

struct EasterEgg: Codable {
    let id: GameableViewId // Issue is if there are duplicate screen occurrences? This might fail.
    private(set) var isDiscovered: Bool
    
    mutating func setDiscovered() {
        isDiscovered = true
    }
    
    init(id: GameableViewId, isDiscovered: Bool) {
        self.id = id
        self.isDiscovered = isDiscovered
    }
    
//    enum CodingKeys: CodingKey {
//        case id
//        case isDiscovered
//    }
//    
//    init(from decoder: Decoder) throws {
//        let vals = try decoder.container(keyedBy: CodingKeys.self)
//        
//        self.id = try vals.decode(GameableViewId.self, forKey: .id) // NSClassFromString(try vals.decode(String.self, forKey: .id))
//        self.isDiscovered = try vals.decode(Bool.self, forKey: .isDiscovered)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(String(describing: id), forKey: .id)
//        try container.encode(isDiscovered, forKey: .isDiscovered)
//    }
}
