//
//  ViewController.swift
//  Concentration
//
//  Created by Marwan Salama on 10/12/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipsCount: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }else{
            print("Selected card is not an element of cardButtons array")
        }
    }
    func updateViewFromModel(){
        
    }
}

