//
//  setContainerView.swift
//  Set HW4
//
//  Created by Marwan Salama on 12/13/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class setContainerView: UIView {
    lazy var grid : Grid = Grid(layout: Grid.Layout.aspectRatio(1))
    var cards = [SingleCardView](){didSet{grid.cellCount = cards.count ;setNeedsDisplay();setNeedsLayout() }}
    private var dealingTimer : Timer!
    var inTheMiddleOfAnimations:Bool{
        get{
            if cards.filter({!$0.isPresented}).count > 0 {
                return true
            }else{
                return false
            }
        }
    }
    var offset : CGSize = CGSize(width: 0, height: 0)
    
    /*
     override func draw(_ rect: CGRect) {
     //grid.cellCount = cards.count
     //grid.frame = bounds
     //clearSubviews()
     //addCards()
     }
     */
    @objc private func dealSingleCard(){
        if cards.filter({!$0.isPresented}).count>0{
            let cardToAnimate = cards.filter({!$0.isPresented})[0]
            if let cardIndex = cards.firstIndex(of: cardToAnimate){
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.4,
                    delay: 0,
                    options: [],
                    animations: { [unowned self] in
                        self.addSubview(self.cards[cardIndex])
                        cardToAnimate.frame = self.grid[cardIndex]!
                        //self.cards[cardIndex].isPresented = true
                    },completion: { position in
                        UIView.transition(
                            with: cardToAnimate,
                            duration: 0.3,
                            options: [.transitionFlipFromLeft,.curveEaseInOut],
                            animations: {
                                cardToAnimate.isPresented = true
                        })
                    }
                )
            }
        }
    }
    
    func addCards(){
        dealingTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(dealSingleCard), userInfo: nil, repeats: false)

    }
    
    func removeMatchedCards(){
        let matchedCards = cards.filter{$0.isSelected}
        for card in matchedCards{
            if let viewIndex = subviews.firstIndex(of: card){
                //print("inside removeMatched")
                subviews[viewIndex].removeFromSuperview()
            }
        }
    }
    
    func shiftCards(){
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.6,
            delay: 0,
            options: [],
            animations: { [unowned self,cards] in
//                self.subviews.forEach{
//                    if let index = self.subviews.index(of: $0){
//                        if let frame = self.grid[index]{
//                            $0.frame = frame
//                        }
//                    }
//                }
                for subview in self.subviews{
                    if let card = subview as? SingleCardView{
                        if card.isPresented{
                            if let indexInCards = cards.firstIndex(of: (card)){
                                if let frame = self.grid[indexInCards]{
                                    subview.frame = frame
                                    
                                }
                            }
                        }
                    }
                }
        }
        )
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        grid.frame = bounds.inset(by: offset)
        grid.cellCount = cards.count
        //clearSubviews()
        shiftCards()
        addCards()
        
    }
    
}

extension UIView
{
    func clearSubviews()
    {
        for subview in self.subviews {
            subview.removeFromSuperview();
        }
    }
}
