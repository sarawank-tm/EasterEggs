//
//  ViewController.swift
//  EasterEggs
//
//  Created by Saravanakumar S on 21/02/23.
//

import UIKit

class GameStatsViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onOk() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    func updateView() {
        let eggs = easterEggGameManager.retrieveEggs()
        let disCount = eggs.filter({$0.isDiscovered}).count
        
        countLabel.text = "\(disCount) of \(eggs.count) Eggs discovered"
        
        var totalText = ""
        for egg in eggs {
            totalText += "ID: \(String(describing: egg.id)) -- \(egg.isDiscovered ? "" : "not") Discovered \n"
        }
        
        statsLabel.text = totalText
    }
}

