//
//  setCard.swift
//  Set HW4
//
//  Created by Marwan Salama on 12/13/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct setCard {
    
    var suit: Suit
    var count: Count
    var color: Color
    var shape: Shape
    var isSelected = false
    var isPresented = false
    var isMatched = false

    
    enum Suit: String, CustomStringConvertible{
        var description: String{
            return rawValue
        }
        
        case triangle = "▲"
        case oval = "●"
        case square = "■"
        
        static var all = [Suit.triangle,.oval,.square]
    }
    
    enum Shape: String, CustomStringConvertible{
        var description: String{
            return rawValue
        }
        case stroke = "stroke"
        case fill = "fill"
        case empty = "empty"
        
        static var all = [Shape.stroke,.fill,.empty]
    }
    
    enum Count: Int, CustomStringConvertible{
        var description: String{
            return String(rawValue)
        }
        case one = 1
        case two
        case three
        
        static var all = [Count.one,.two,.three]
    }
    
    enum Color: String, CustomStringConvertible{
        var description: String{
            return rawValue
        }
        case red = "red"
        case green = "green"
        case purple = "purple"
        
        static var all = [Color.red,.green,.purple]
    }
    
    

}

extension setCard: Equatable, CustomStringConvertible{
    static func ==(lhs: setCard, rhs: setCard) ->Bool{
//        return (lhs.color == rhs.color && lhs.count == rhs.count && lhs.suit == rhs.suit && lhs.shape != rhs.shape) ||
//                (lhs.color != rhs.color && lhs.count != rhs.count && lhs.suit != rhs.suit && lhs.shape == rhs.shape) ||
//                (lhs.color != rhs.color && lhs.count != rhs.count && lhs.suit != rhs.suit && lhs.shape != rhs.shape)
      return  lhs.shape == rhs.shape
        && lhs.color == rhs.color
        && lhs.suit == rhs.suit
        && lhs.count == rhs.count
    }
    var description: String{
        return "color: \(color) , count:\(count), shape:\(shape), suit:\(suit)"
    }
}
