//
//  Card.swift
//  Concentration
//
//  Created by Marwan Salama on 10/12/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import Foundation

struct Card{
    var isMatched = false
    var identifier: Int
    var isFacedUp = false
    
    static func generateUniqueIdentifier() -> Int{
        identifierFactory += 1;
        return identifierFactory
    }
    
    static var identifierFactory = 0
}
