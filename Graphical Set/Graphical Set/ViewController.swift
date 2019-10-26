//
//  ViewController.swift
//  Graphical Set
//
//  Created by Marwan Salama on 10/22/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = setGame()
    
    @IBOutlet weak var setCardsViewContainer: SetCardsContainerView! {
        didSet{
            updateViewFromModel()
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpHandler(recognizer:)))
            swipeGestureRecognizer.direction = [.up,.down]
            self.setCardsViewContainer.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    
    @objc func swipeUpHandler(recognizer: UISwipeGestureRecognizer){
        game.deal3MoreCards()
        updateViewFromModel()
    }
    
    func createCardView(From card: Card) -> setCardView{
        var color : UIColor {
            switch card.color {
            case .red:
                return UIColor.red
            case .purple:
                return UIColor.purple
            case .green:
                return UIColor.green
            }
        }
        var shape : Int {
            switch card.shape {
            case .circle:
                return 3
            case .square:
                return 1
            case .triangle:
                return 2
            }
        }
        var shade : Int{
            switch card.shade {
            case .empty:
                return 1
            case .fill:
                return 2
            case .stroke:
                return 3
            }
        }
        let cardView = setCardView()
        cardView.backgroundColor = UIColor.white
        cardView.color = color
        cardView.shape = shape
        cardView.shade = shade
        cardView.pipsCount = card.pipsCount
        cardView.isSelected = game.selectedCards.contains(card)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchCard(recognizer:)))
        cardView.addGestureRecognizer(tapGestureRecognizer)
        return cardView
        
    }
    @objc func touchCard(recognizer : UITapGestureRecognizer){
        if let view = recognizer.view as? setCardView{
            view.isSelected = !view.isSelected
            if let indexOfCardView = setCardsViewContainer.subviews.firstIndex(of: view){
                game.selectCard(at: indexOfCardView)
            }
        }
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        setCardsViewContainer.grid.dimensions = ((game.playingCards.count/4)+1,4)
        for view in setCardsViewContainer.subviews{
            view.removeFromSuperview()
        }
        for card in game.playingCards{
            let cardView = createCardView(From: card)
            cardView.frame = setCardsViewContainer.grid[game.playingCards.firstIndex(of: card)!]!
            setCardsViewContainer.addSubview(cardView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

