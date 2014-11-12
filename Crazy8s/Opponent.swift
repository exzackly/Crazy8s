//
//  Opponent.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/11/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

class Opponent: NSObject, PPlayer, Printable {
    var score = 0
    var hand = [Card]()
    override var description: String {
        var returnString = "Opponent: \(hand.count) cards\n"
        for card in hand {
            returnString += "\(card)\n"
        }
        return returnString
    }
    func playCard(player: Player) {
        println("opponent taking turn")
        //player.playCard(self)
    }
}
