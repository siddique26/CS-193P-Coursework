//
//  ViewController.swift
//  concentration
//
//  Created by Siddique on 30/11/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int{
        get{
           return (cardbuttons.count + 1) / 2
        }
    }
    
     private(set) var flipCount = 0{
        didSet{
           
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private var score: Int = 0
   
   
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardbuttons: [UIButton]!
    
    
    var emojiThemes = ["halloween" : ["🦇","😱","🙀","👿","🎃","👻","🍭","🍬","🍎","🌑"],
                       "animals" : ["🐶","🐱","🐼","🐰","🐻","🐯","🐵","🦆","🦋","🐿"],
                       "sports" : ["⚽️","🏀","🏈","⚾️","🎾","🏸","🥊","🏄🏼‍♂️","🚴‍♀️","🏊🏽‍♂️"],
                       "food" : ["🍇","🍓","🍌","🌽","🍔","🍟","🍝","🍩","🍫","🍿"],
                       "space" : ["🚀","🛰","🛸","🌑","🌕","🌎","☄️","🌌","📡","🔭"],
                       "entertainments" : ["🎥","💸","🌋","🗽","🗿","🗺","🏝","🚠","🎮","🎬"]]
    
    lazy var emojiThemesKeys = Array(emojiThemes.keys)
    
    var randomTheme: String {
        get {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemesKeys.count - 1)))
            return emojiThemesKeys[randomIndex]
        }
    }
     lazy var emojiChoices = emojiThemes[randomTheme]!
  
    
    @IBAction func restartButton(_ sender: UIButton) {
        game.restart()
        updateViewFromModel()
        flipCount = 0
        score = 0
    }
    
   
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardbuttons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Chosen card is not found")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardbuttons.indices{
            let button = cardbuttons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        //update Score
        scoreLabel.text = "Score: \(game.gameScore)"
    }
   
    private var emoji = [Card : String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count>0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
    return emoji[card] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int{
        if self > 0{
        return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}


