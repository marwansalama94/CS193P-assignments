//
//  setDeck.swift
//  Set HW4
//
//  Created by Marwan Salama on 12/13/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct setDeck{
    private(set) var score = 0
    private(set) var sets = 0
    private(set) var thereWasMatch = false
    private var deck = [setCard]()
    private var playerDeck = [setCard]()
    private(set) var noMoreCardsToDeal = false
    private var selectedCards = [setCard]()
    
    private mutating func fillPlayerDeck(){
        for card in 0..<12{
            playerDeck.append(deck.remove(at: card))
        }
    }
    
    init(){
        for color in setCard.Color.all{
            for shape in setCard.Shape.all{
                for suit in setCard.Suit.all{
                    for count in setCard.Count.all{
                        deck += [setCard(suit: suit, count: count, color: color, shape: shape, isSelected: false, isPresented: false, isMatched: false)]
                    }
                }
            }
        }
        deckShuffler()
        fillPlayerDeck()
        //printAll()
    }
    
    mutating func cardsToPresent()->[setCard]{
        var toPresent = [setCard]()
        for index in playerDeck.indices{
            if !playerDeck[index].isPresented{
                playerDeck[index].isPresented = true
                toPresent.append(playerDeck[index])
            }
        }
        return toPresent
    }
    
    mutating func chooseCard(at index:Int){
        thereWasMatch = false
        playerDeck[index].isSelected = !playerDeck[index].isSelected
        selectedCards = playerDeck.filter{ $0.isSelected }
        //print(playerDeck[index])
        //print((deck.count))
        if selectedCards.count == 3 {
            checkForMatch()
            for index in playerDeck.indices{
                playerDeck[index].isSelected = false
            }
            
        }
    }
    
    
    private mutating func removeFromDeck(){
        thereWasMatch = true
        for card in selectedCards{
            if let index = playerDeck.firstIndex(of: card){
                if deck.count > 0{
                    playerDeck[index] = deck.remove(at: 0)
                }else{
                    playerDeck.remove(at: index)
                }
                
            }
        }
    }
    
    private func checkForMatch(firstCard : setCard, secondCard : setCard , thirdCard: setCard)->Bool{
        return compareTwoCards(lhs: firstCard, rhs: secondCard) && compareTwoCards(lhs: secondCard, rhs: thirdCard)
    }
    
    private func compareTwoCards(lhs: setCard , rhs: setCard)->Bool{
        return (lhs.color == rhs.color && lhs.count == rhs.count && lhs.suit == rhs.suit && lhs.shape != rhs.shape) ||
                        (lhs.color != rhs.color && lhs.count != rhs.count && lhs.suit != rhs.suit && lhs.shape == rhs.shape) ||
                        (lhs.color != rhs.color && lhs.count != rhs.count && lhs.suit != rhs.suit && lhs.shape != rhs.shape)
    }
    
    mutating func deal3MoreCards(){
        if deck.count>2
        {
            for _ in 0..<3{
                playerDeck.append(deck.remove(at: 0))
            }
        }else{
            noMoreCardsToDeal = true
        }
        
    }
    
     private mutating func checkForMatch() {
        let firstCard = selectedCards[0]
        let secondCard = selectedCards[1]
        let thirdCard = selectedCards[2]
        if checkForMatch(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard){
            score += 1
            sets += 1
            removeFromDeck()
        }else{
            score -= 1
        }
            selectedCards.removeAll()
    }

    private mutating func deckShuffler(){
        for x in 1...1000{
            let firstIndex = x.arc4random
            let secondIndex = x.arc4random
            if firstIndex<deck.count , secondIndex<deck.count{
             deck.swapAt(firstIndex, secondIndex)
            }
        }
    }
    
    
    
}


extension Int {
    var arc4random: Int{
        if self>0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self<0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
        
    }
}
