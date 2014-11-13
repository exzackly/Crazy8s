//
//  Deck.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/11/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

class Deck: NSObject, Printable {
    var cards: [Card] = []
    var discards: [Card] = []
    override init() {
        for var rankTemp = 1; rankTemp != 14; rankTemp++ {
            for var suitTemp = 1; suitTemp != 5; suitTemp++ {
                cards.append(Card(frame: CGRectNull, rank: rankTemp, suit: suitTemp))
            }
        }
        super.init()
        self.shuffle()
    }

    
    func drawCard() -> Card {
        if cards.isEmpty {discardsToCards()}
        return cards.removeAtIndex(0)
    }
    
    func discardCard(card: Card) {
        discards.insert(card, atIndex: 0)
    }
    
    func shuffle() {
        for var temp = 0; temp != cards.count; temp++ {
            let tempInt = Int(arc4random()) % cards.count
            (cards[temp], cards[tempInt]) = (cards[tempInt], cards[temp])
        }
    }
    
    func discardsToCards() {
        for var temp = 1; temp != discards.count; temp++ {
            let tempCard = discards.removeAtIndex(temp)
            tempCard.text = "\(tempCard)"
            cards.append(tempCard)
        }
        shuffle()
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
