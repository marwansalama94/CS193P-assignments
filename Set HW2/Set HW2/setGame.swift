//
//  setGame.swift
//  Set HW2
//
//  Created by Marwan Salama on 10/17/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct setGame{
    var cards = [Card]()
    
    mutating func CreateDeckOfCards(){
        for pips in 1..<4{
            for suit in Card.Suit.all{
                for color in Card.Color.all{
                    for shape in Card.Shape.all{
                        let card = Card(pipsCount: pips, color: color, suit: suit, shape: shape)
                        cards.append(card)
                    }
                }
            }
        }
    }
    
    init(){
        CreateDeckOfCards()
        //let subCards = cards.shuffled()
        print("\(cards.count)")
        for card in cards{
            print("\(card)")
        }
    }
}
