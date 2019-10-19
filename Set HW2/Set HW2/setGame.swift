//
//  setGame.swift
//  Set HW2
//
//  Created by Marwan Salama on 10/17/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct setGame{
    private var cards = [Card]()
    private(set) var playingCards = [Card]()
    private var selectedCards = [Card]()
    
    mutating func CreateDeckOfCards(){
        for pips in 1..<4{
            for shade in Card.Shade.all{
                for color in Card.Color.all{
                    for shape in Card.Shape.all{
                        let card = Card(pipsCount: pips, color: color, shade: shade, shape: shape)
                        cards.append(card)
                    }
                }
            }
        }
    }
    
    mutating func deal3MoreCards(){
        if cards.count >= 3{
            for _ in 0..<3{
                playingCards.append(cards.remove(at: 0))
            }
        }
    }
    
    private func firstMatchingRule(firstCard: Card,secondCard: Card,thirdCard: Card)-> Bool{
        return (
            (firstCard.shape == secondCard.shape && secondCard.shape == thirdCard.shape) &&
            (firstCard.color == secondCard.color && secondCard.color == thirdCard.color) &&
            (firstCard.pipsCount == secondCard.pipsCount && secondCard.pipsCount == thirdCard.pipsCount) &&
            (firstCard.shade != secondCard.shade && firstCard.shade != thirdCard.shade && secondCard.shade != thirdCard.shade))
    }
    
    private func secondMatchingRule(firstCard: Card,secondCard: Card,thirdCard: Card)-> Bool{
        return (
            (firstCard.shade == secondCard.shade && secondCard.shade == thirdCard.shade) &&
            (firstCard.shape != secondCard.shape && firstCard.shape != thirdCard.shape && secondCard.shape != thirdCard.shape) &&
            (firstCard.color != secondCard.color && firstCard.color != thirdCard.color && secondCard.color != thirdCard.color) &&
            (firstCard.pipsCount != secondCard.pipsCount && firstCard.pipsCount != thirdCard.pipsCount && secondCard.pipsCount != thirdCard.pipsCount)
        )
    }
    
    private func thirdMatchingRule(firstCard: Card,secondCard: Card,thirdCard: Card)-> Bool{
        return (
            (firstCard.shade != secondCard.shade && firstCard.shade != thirdCard.shade && secondCard.shade != thirdCard.shade) &&
            (firstCard.shape != secondCard.shape && firstCard.shape != thirdCard.shape && secondCard.shape != thirdCard.shape) &&
            (firstCard.color != secondCard.color && firstCard.color != thirdCard.color && secondCard.color != thirdCard.color) &&
            (firstCard.pipsCount != secondCard.pipsCount && firstCard.pipsCount != thirdCard.pipsCount && secondCard.pipsCount != thirdCard.pipsCount)
        )
    }
    
    
    private func PotentialMatch() -> Bool{
        let firstCard = selectedCards[0]
        let secondCard = selectedCards[1]
        let thirdCard = selectedCards[2]
        /* Matching rules
         1- same shape, same color,same number of symbols and different shading
         2- different shapes, different colors, same shading , different number of symbols
         3- different shapes, different colors, different shading and different number of symbols
         */
        return firstMatchingRule(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard) ||
            secondMatchingRule(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard) ||
            thirdMatchingRule(firstCard: firstCard, secondCard: secondCard, thirdCard: thirdCard)
        
    }
    
    mutating func selectCard(at index:Int){
        let selectedCard = playingCards[index]
        if selectedCards.contains(selectedCard){
            let index = selectedCards.firstIndex(of: selectedCard)!
            selectedCards.remove(at: index)
        }else{
            if selectedCards.count == 3{
                if PotentialMatch(){
                    for card in selectedCards{
                        playingCards.remove(at: playingCards.firstIndex(of: card)!)
                    }
                    selectedCards.removeAll()
                    if !cards.isEmpty{
                        deal3MoreCards()
                    }
                }
            }else{
                //just add me to the selectedCards array
                selectedCards.append(selectedCard)
            }
        }
    }
    
    init(){
        CreateDeckOfCards()
        cards = cards.shuffled()
        for _ in 0..<4{
            deal3MoreCards()
        }
    }
}
