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
    var flipsCount = 0
    var facedUpAndOnlyCard : Int?{
        get {
            return cards.indices.filter { cards[$0].isFacedUp }.oneAndOnly
        }
        set{
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        if let indexOfCard = facedUpAndOnlyCard{
            //in the case of a second card was selected check if they match
        }else{
            //either two cards are faced up or none
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card(identifier: Card.generateUniqueIdentifier())
            cards.append(card)
            cards.append(card)
        }
        //TODO: shuffle the cards
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
