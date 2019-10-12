//
//  Concentration.swift
//  Concentration
//
//  Created by Marwan Salama on 10/12/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct Concentration{
    var cards = [Card]()
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card(identifier: Card.generateUniqueIdentifier())
            cards.append(card)
            cards.append(card)
        }
        //TODO: shuffle the cards
    }
    
}
