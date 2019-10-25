//
//  Card.swift
//  Set HW2
//
//  Created by Marwan Salama on 10/16/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible{
    let pipsCount : Int
    let color : Color
    let shade : Shade
    let shape : Shape
    
    var description: String {return "\(shape),\(shade),\(color),pips:\(pipsCount)"}
    
    
    enum Color: CustomStringConvertible{
        case red
        case green
        case purple
        
        static var all = [Color.red, Color.green, Color.purple]
        var description: String {
            switch self{
            case .red: return "red"
            case .green: return "green"
            case .purple: return "purple"
            }
        }
    }
    
    enum Shade: CustomStringConvertible {
        case stroke
        case fill
        case empty
        
        static var all = [Shade.stroke, Shade.fill, Shade.empty]
        
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

extension Card: Equatable{
    static func == (lhs: Card, rhs: Card) -> Bool {
        return
            lhs.pipsCount == rhs.pipsCount  &&
            lhs.shape == rhs.shape &&
            lhs.shade == rhs.shade  &&
            lhs.color == rhs.color
    }
    
}
