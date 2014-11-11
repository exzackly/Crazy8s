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
    var players = [PPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players.append(Player())
        players.append(Opponent())
        self.dealCards()
        println(players[0])
        println(players[1])
        println(deck)
    }
    
    func dealCards() {
        for var temp = 0; temp != 8; temp++ {
            for var playerID = 0; playerID != players.count; playerID++ {
                players[playerID].hand.append(deck.drawCard())
            }
        }
    }
    
}

