//
//  ViewController.swift
//  Set HW2
//
//  Created by Marwan Salama on 10/16/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    var game = setGame()
    
    @IBOutlet var cardButtons: [UIButton]!{
        didSet{
            updateViewFromModel()
        }
    }
    
    var freeButtons : [UIButton] {
        return cardButtons.filter{ $0.backgroundColor == #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) }
    }
    
    @IBAction func request3MoreCards(_ sender: UIButton) {
        let buttons = freeButtons
        if buttons.count >= 3{
            game.deal3MoreCards()
            updateViewFromModel()
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cardButtons.firstIndex(of: sender){
            game.selectCard(at: index)
        }
        updateViewFromModel()
        
    }
    
    func drawCard(withAttributesOf card:Card,at index: Int){
        var text = String()
        var singlePip : String{
            switch card.shape{
            case .circle:
                return "●"
            case .square:
                return "■"
            case .triangle:
                return "▲"
            }
        }
        var color :UIColor {
            switch card.color {
            case .green:
                return UIColor.green
            case .purple:
                return UIColor.purple
            case .red:
                return UIColor.red
            }
        }
        for _ in 0..<card.pipsCount{
            text += singlePip
        }
        var attributes : [NSAttributedString.Key : Any] {
            switch card.shade{
            case .empty:
                return [.strokeColor : color , .strokeWidth : 3]
            case .fill:
                return [.foregroundColor : color.withAlphaComponent(CGFloat(1))]
            case .stroke:
                return [.foregroundColor : color.withAlphaComponent(CGFloat(0.15))]
            }
        }
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        cardButtons[index].setAttributedTitle(attributedString, for: UIControl.State.normal)
    }
    
    func updateViewFromModel(){
        for index in game.playingCards.indices{
            let card = game.playingCards[index]
            let button = cardButtons[index]
            drawCard(withAttributesOf:card,at: index)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            if game.selectedCards.contains(card){
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.blue.cgColor
                button.layer.cornerRadius = 8.0
            }else{
                button.layer.borderWidth = 0
                button.layer.borderColor = nil
                button.layer.cornerRadius = 0
            }
        }
        for index in game.playingCards.count..<cardButtons.count{
            cardButtons[index].setAttributedTitle(nil, for: UIControl.State.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }

}


