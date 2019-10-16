//
//  ViewController.swift
//  Concentration
//
//  Created by Marwan Salama on 10/12/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         pickRandomTheme()
    }
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipsCount: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        game.instaniateNewGame()
        startNewGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }else{
            print("Selected card is not an element of cardButtons array")
        }
    }
    
    var emojiChoices = [
                            ["🐝", "🐛", "🐌", "🐞", "🐜", "🐢", "🐍", "🦎", "🐙", "🦑", "🦞", "🐠"],
                            ["🍋", "🍌", "🥥", "🌽", "🥬", "🍎", "🍒", "🍉", "🌶", "🍑","🥦", "🍆"],
                            ["😀", "😱", "🤡", "😤", "😈", "🤖", "🎃", "👾", "👻", "😻", "🥶", "😡"]
                        ]
    
    func startNewGame(){
        for button in cardButtons{
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            button.setTitle("", for: UIControl.State.normal)
        }
        flipsCount.text = "Flips:\(game.flipsCount)"
        scoreLabel.text = "Score:\(game.score)"
        pickRandomTheme()
    }
    
    var chosenTheme = [String]()
    var emoji = [Int: String]()
    
    func pickRandomTheme(){
        let randomIndex = emojiChoices.count.arc4random
        chosenTheme = emojiChoices[randomIndex]
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, chosenTheme.count > 0 {
            let randomIndex = (chosenTheme.count).arc4random
            emoji[card.identifier] = chosenTheme.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func updateViewFromModel(){
        for index in game.cards.indices{
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFacedUp {
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            }else{
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            }
        }
        flipsCount.text = "Flips:\(game.flipsCount)"
        scoreLabel.text = "Score:\(game.score)"
    }
}

extension Int{
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
        
    }
}
