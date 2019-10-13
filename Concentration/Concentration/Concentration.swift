//
//  Concentration.swift
//  Concentration
//
//  Created by Marwan Salama on 10/12/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    private(set) var flipsCount = 0
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
    
    mutating func chooseCard(at index: Int){
        if !cards[index].isMatched && !cards[index].isFacedUp {
            if let indexOfChosenCard = facedUpAndOnlyCard , indexOfChosenCard != index {
                //in the case of a second card was selected check if they match
                if cards[indexOfChosenCard].identifier == cards[index].identifier{
                    cards[indexOfChosenCard].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            }else{
                //either two cards were faced up or none
                facedUpAndOnlyCard = index
            }
            flipsCount += 1
        }
    }
    
    private mutating func shuffleCards(){
        for _ in 0...1000{
            let firstCardIndex = Int(arc4random_uniform(UInt32(cards.count-1)))
            let secondCardIndex = Int(arc4random_uniform(UInt32(cards.count-1)))
            let firstCardCopy = cards[firstCardIndex]
            cards[firstCardIndex] = cards[secondCardIndex]
            cards[secondCardIndex] = firstCardCopy
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card(identifier: Card.generateUniqueIdentifier())
            cards.append(card)
            cards.append(card)
        }
        shuffleCards()
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
