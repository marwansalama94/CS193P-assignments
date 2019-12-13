//
//  ViewController.swift
//  Set HW4
//
//  Created by Marwan Salama on 12/13/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var setsLabel: UILabel!
    var engine = setDeck()
    @IBOutlet weak var setLabelContainer: UIView!
    @IBOutlet weak var deck: UIView!
    @IBOutlet weak var parentView: setContainerView!{ didSet{ updateViewFromModel();parentView.offset = deck.frame.size }}
    
    @IBAction func dealCards(_ sender: UITapGestureRecognizer) {
        switch sender.state{
        case .ended:
            //deck.isUserInteractionEnabled = false
            if !parentView.inTheMiddleOfAnimations{
                engine.deal3MoreCards()
                updateViewFromModel()
            }
        default:
            break
        }
    }
    
    func updateViewFromModel(){
        //parentView.cards.removeAll()
        let toPresentCards = engine.cardsToPresent()
        let SelectedCardViews = parentView.cards.filter{$0.isSelected}
        if SelectedCardViews.count > 2, (SelectedCardViews.count == toPresentCards.count || engine.thereWasMatch){
            parentView.removeMatchedCards()
            setsLabel.text = "\(engine.sets) Set"
            insertCards(from : toPresentCards, toReplace: SelectedCardViews)
        }else{
            for SetCard in toPresentCards{
                let card = configureCardView(SetCard)
                parentView.cards.append(card)
            }
        }
        if engine.sets>0{
            setLabelContainer.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        if engine.noMoreCardsToDeal{
            deck.isHidden = true
        }
    }
    
    func configureCardView(_ SetCard: setCard)-> SingleCardView{
        let card = SingleCardView(frame: deck.frame)
        card.color = SetCard.color
        card.count = SetCard.count
        card.shape = SetCard.shape
        card.suit = SetCard.suit
        card.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectCard(recognizedBy: )))
        tap.numberOfTapsRequired = 1
        card.addGestureRecognizer(tap)
        return card
    }
        
    func insertCards(from:[setCard],toReplace SelectedCardViews:[SingleCardView]){
        for cardIndex in SelectedCardViews.indices{
            if let index = parentView.cards.firstIndex(of: SelectedCardViews[cardIndex]){
                if from.count == 0 {
                    parentView.cards.remove(at: index)
                }else{
                    parentView.cards[index] = configureCardView(from[cardIndex])
                }
            }
        }
    }
    
    @objc func selectCard(recognizedBy recognizer:UITapGestureRecognizer){
        if let selectedCard = recognizer.view as? SingleCardView {
            let selectedCardViews = parentView.cards.filter{$0.isSelected}
            if selectedCardViews.count>2{
                for card in selectedCardViews{
                    parentView.cards[parentView.cards.firstIndex(of: card)!].isSelected = false
                }
            }
            if let indexOfSelectedCard = parentView.cards.firstIndex(of: selectedCard){
                parentView.cards[indexOfSelectedCard].isSelected = !parentView.cards[indexOfSelectedCard].isSelected
                engine.chooseCard(at: indexOfSelectedCard)
                updateViewFromModel()
            }
        }
        
    }
}


