//
//  ViewController.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/10/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

protocol PPlayer {
    var score: Int {get set}
    var hand: [Card] {get set}
}

class ViewController: UIViewController {
    let deck = Deck()
    var player = Player()
    var opponent = Opponent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dealCards()
        println(player)
        println(opponent)
        println(deck)
    }
    
    func drawScreen() {
        
    }
    
    func dealCards() {
        for var temp = 0; temp != 8; temp++ {
            player.hand.append(deck.drawCard())
            opponent.hand.append(deck.drawCard())
        }
    }
    
}

