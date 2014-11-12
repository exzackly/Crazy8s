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
        if rank == 1 {return "A"}
        if rank == 11 {return "J"}
        if rank == 12 {return "Q"}
        if rank == 13 {return "K"}
        return "error"
    }
    func decodeSuit() -> String {
        if suit == 1 {return "♣"}
        if suit == 2 {return "♦"}
        if suit == 3 {return "♥"}
        if suit == 4 {return "♠"}
        return "error"
    }
    
    override var description: String {
        return decodeRank() + decodeSuit()
    }
}
