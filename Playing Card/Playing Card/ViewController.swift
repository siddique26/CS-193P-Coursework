//
//  ViewController.swift
//  Playing Card
//
//  Created by Siddique on 07/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state{
        case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break
        }
    }
    
    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet{
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left,.right]
            playingCardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizerBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
   @objc func nextCard(){
        if let card = deck.draw(){
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }



}

