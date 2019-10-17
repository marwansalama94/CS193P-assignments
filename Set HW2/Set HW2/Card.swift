//
//  Card.swift
//  Set HW2
//
//  Created by Marwan Salama on 10/16/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible{
    var pipsCount:Int
    var color : Color
    var suit : Suit
    var shape : Shape
    var description: String {return "\(shape),\(suit),\(color),pips:\(pipsCount)"}
    
    enum Color: String,CustomStringConvertible{
        case red
        case green
        case purple
        
        static var all = [Color.red, Color.green, Color.purple]
        var description: String { return rawValue}
    }
    
    enum Suit: CustomStringConvertible {
        case stroke
        case fill
        case empty
        
        static var all = [Suit.stroke, Suit.fill, Suit.empty]
        
        var description: String{
            switch self{
            case .empty: return "empty"
            case .stroke: return "stroke"
            case .fill: return "fill"
            }
        }
    }
    
    enum Shape: CustomStringConvertible{
        case square
        case triangle
        case circle
        
        static var all = [Shape.square,Shape.triangle,Shape.circle]
        var description: String{
            switch self{
            case .circle: return "circle"
            case .triangle : return "triangle"
            case .square : return "square"
            }
        }
    }
    
    
}
