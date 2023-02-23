//
//  ViewController.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import UIKit

class MainViewController: UIViewController {

    fileprivate func addGameStatsButton() {
        let barButton = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(onGameStats))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        implementEasterEggFeature()
        addGameStatsButton()
    }
    
    @objc func onGameStats() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameStats")
        self.present(vc, animated: true)
    }
}

extension MainViewController: GameableView {}
extension SecondViewController: GameableView {}
extension ThirdViewController: GameableView {}
extension FourthViewController: GameableView {}
extension FirstModalController: GameableView {}


protocol GameableView {
    func implementEasterEggFeature()
    var gameableViewId: GameableViewId { get }
}

enum GameableViewId: Codable {
    case mainView
    case secondView
    case thirdView
    case fourthView
    case firstModal
}

extension GameableViewId {
    
    static func getIdForViewType<T: GameableView>(_ type: T.Type) -> Self {
        switch type {
        case is MainViewController.Type: return .mainView
        case is SecondViewController.Type: return .secondView
        case is ThirdViewController.Type: return .thirdView
        case is FourthViewController.Type: return .fourthView
        case is FirstModalController.Type: return .firstModal
        default: fatalError()
        }
    }
    
//    func getViewForId(_ id: GameableViewId) -> GameableView.Type {
//        switch self {
//        case .mainView:
//            return MainViewController.self
//        case .secondView:
//            return SecondViewController.self
//        case .thirdView:
//            return ThirdViewController.self
//        case .fourthView:
//            return FourthViewController.self
//        case .firstModal:
//            return FirstModalController.self
//        }
//    }
}

extension GameableView where Self: UIViewController {
    
    var gameableViewId: GameableViewId {
        GameableViewId.getIdForViewType(Self.self)
    }
    
    func implementEasterEggFeature() {
//        if easterEggGameManager.isEligible(view: Self.self) { // Returns egg object if eligible, which tells id and is it already captured?
//            addEasterEgg()
//        }
        
        if let egg = easterEggGameManager.retrieveEgg(for: gameableViewId),
           !egg.isDiscovered {
            addEasterEgg(egg)
        }
//        let str = NSStringFromClass(Self.self)
//        let str1 = NSStringFromClass(Self.classForCoder())
    }
    
//    private func addEasterEgg(_ egg: EasterEgg) {
//        let easterEgg = UIImage(named: "easter_egg")
//        let screenSize = UIScreen.main.bounds
////        UIScreen.main.focusedView?.layoutGuides
//
//        let y = CGFloat.random(in: 0..<(screenSize.height-100))
//        let x = CGFloat.random(in: 0..<(screenSize.width-100))
//
//        let action = UIAction(title: "", image: easterEgg, identifier: UIAction.Identifier(String(describing: egg.id)), discoverabilityTitle: nil, attributes: .hidden, state: .off) { action in
//            guard let senderButton = action.sender as? UIButton else {
//                return
//            }
//
//            easterEggGameManager.eggTapped(egg)
//            senderButton.removeFromSuperview()
//        }
//        let button = UIButton(frame: .init(x: x, y: y, width: 100, height: 133), primaryAction: action)
//        view.addSubview(button)
//    }
    
    private func addEasterEgg(_ egg: EasterEgg) {
        let easterEgg = UIImage(named: "easter_egg")
        let screenSize = UIScreen.main.bounds
        
        let y = CGFloat.random(in: 0..<(screenSize.height-100))
        let x = CGFloat.random(in: 0..<(screenSize.width-100))
        let butn = UIButton(frame: .init(x: x, y: y, width: 100, height: 133))
        butn.addTarget(self, action: #selector(onEasterEggButtonTap(_:)), for: .touchUpInside)
        butn.setImage(easterEgg, for: .normal)
        view.addSubview(butn)
    }
}

extension UIViewController {
    
    @objc func onEasterEggButtonTap(_ sender: UIButton) {
        guard let type = self as? GameableView else {
            return
        }
        
        easterEggGameManager.eggTapped(withId: type.gameableViewId)
        sender.removeFromSuperview()
    }
}
