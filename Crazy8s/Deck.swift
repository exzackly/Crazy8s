//
//  Deck.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/11/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

class Deck: NSObject, Printable {
    var cards = [Card]()
    var discards = [Card]()
    override init() {
        for var rankTemp = 1; rankTemp != 14; rankTemp++ {
            for var suitTemp = 1; suitTemp != 5; suitTemp++ {
                cards.append(Card(rank: rankTemp, suit: suitTemp))
            }
        }
    }
    override var description: String {
        var returnString = "\(cards.count) Cards:\n"
        for card in cards {
            returnString += "\(card)\n"
        }
        returnString += "\n\(discards.count) Discards:\n"
        for card in discards {
            returnString += "\(card)\n"
        }
        return returnString
    }
}
