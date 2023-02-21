//
//  ViewController.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        implementEasterEggFeature()
    }
}

extension MainViewController: GameableView {}
extension SecondViewController: GameableView {}
extension ThirdViewController: GameableView {}
extension FourthViewController: GameableView {}
extension FirstModalController: GameableView {}


protocol GameableView {
    func implementEasterEggFeature()
}


extension GameableView where Self: UIViewController {
    
    func implementEasterEggFeature() {
//        if easterEggGameManager.isEligible(view: Self.self) { // Returns egg object if eligible, which tells id and is it already captured?
//            addEasterEgg()
//        }
        
        if let egg = easterEggGameManager.retrieveEgg(for: Self.self),
           !egg.isDiscovered {
            addEasterEgg(egg)
        }
    }
    
    private func addEasterEgg(_ egg: EasterEgg) {
        let easterEgg = UIImage(named: "easter_egg")
        let screenSize = UIScreen.main.bounds
        
        let y = CGFloat.random(in: 0..<(screenSize.height-100))
        let x = CGFloat.random(in: 0..<(screenSize.width-100))
        
        let action = UIAction(title: "", image: easterEgg, identifier: UIAction.Identifier(String(describing: egg.id)), discoverabilityTitle: nil, attributes: .hidden, state: .off) { action in
            
            easterEggGameManager.eggTapped(egg)
            if let eggView = self.view.viewWithTag(4551) {
                eggView.removeFromSuperview()
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameStats")
                self.present(vc, animated: true)
            }
        }
        let button = UIButton(frame: .init(x: x, y: y, width: 100, height: 133), primaryAction: action)
        button.tag = 4551
        view.addSubview(button)
    }
}
