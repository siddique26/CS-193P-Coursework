//
//  Card.swift
//  concentration
//
//  Created by Siddique on 01/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int{return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory: Int = 0
    
    private static func getUniqueIdentifier() -> Int {
        
        identifierFactory += 1
        return identifierFactory
        
    }
    
    init(){
        
        self.identifier = Card.getUniqueIdentifier()
        
    }
    
}
