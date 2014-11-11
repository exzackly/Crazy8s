//
//  Card.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/10/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

class Card: NSObject, Printable {
    let suit: Int
    let rank: Int
    init(rank: Int, suit: Int) {
        self.rank = rank
        self.suit = suit
    }
    func decodeRank() -> String {
        if rank > 1 && rank < 11 {return "\(rank)"}
        if rank == 1 {return "Ace"}
        if rank == 11 {return "Jack"}
        if rank == 12 {return "Queen"}
        if rank == 13 {return "King"}
        return "error"
    }
    func decodeSuit() -> String {
        if suit == 1 {return "Clubs"}
        if suit == 2 {return "Diamonds"}
        if suit == 3 {return "Hearts"}
        if suit == 4 {return "Spades"}
        return "error"
    }
    
    override var description: String {
        var rankString = ""
        var suitString = ""
        return decodeRank() + " of " + decodeSuit()
    }
}
