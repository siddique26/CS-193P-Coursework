//
//  concentration.swift
//  concentration
//
//  Created by Siddique on 01/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import Foundation

struct Concentration{
    
    private(set) var cards = [Card]()
    
    //Computed properites
   private var oneCard : Int?{
        get{
            //Simplified Code
            //   let faceUpCardIndices = cards.indices.filter {cards[$0].isFaceUp}
            // return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            //find which index is flipped Up
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                    foundIndex = index
                }else{
                    return nil
                }
            }
        }
        return foundIndex
        }
        set(newValue) {
            //flipdown all the card except the oneCard
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
                }
            }
        }
    
    var gameScore = 0
    
    var seenCard = [Int:Int]()
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Chosen index is not found")
        if !cards[index].isMatched{
            if seenCard[index] == nil{
                seenCard[index] = 1
            }else{
                seenCard[index]! += 1
            }
            if let matchIndex = oneCard , matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 1
                }
                cards[index].isFaceUp = true
            }else{
                //either no cards or 2 cardsUp
                //for flipDown in cards.indices{
                  //  cards[flipDown].isFaceUp = false
                //}
                //cards[index].isFaceUp = true
                oneCard = index
            }
        }
    }
   mutating func restart()  {
        for all in cards.indices{
            cards[all].isFaceUp = false
            cards[all].isMatched = false
            gameScore = 0
        }
        self.shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have one pair of Cards")
        for _ in 1...numberOfPairsOfCards{
        let card = Card()
        cards += [card, card]
        }
        self.shuffle()
    }
    
   mutating func shuffle(){
        var shuffleCards = [Card]()
        for _ in 1..<cards.count{
            let randomIndex = Int( arc4random_uniform(UInt32(cards.count)))
            shuffleCards.append(cards.remove(at: randomIndex))
        }
        shuffleCards.append(cards.remove(at: 0))
        cards += shuffleCards
    }
    
}
