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
    func playCard(deck: Deck) -> Card {
        println("playing card")
        for (cardNum, card) in enumerate(hand) {
            if countElements(deck.discards[0].text!) == 1 {if  "\(card.decodeSuit())" == deck.discards[0].text {deck.discardCard(card); return hand.removeAtIndex(cardNum)}}
            else if (card.rank == deck.discards[0].rank) || (card.suit == deck.discards[0].suit) && card.rank != 8 {deck.discardCard(card); return hand.removeAtIndex(cardNum)}
        }
        for (cardNum, card) in enumerate(hand) {
            if card.rank == 8 {deck.discardCard(card); return hand.removeAtIndex(cardNum)}
        }
        hand.append(deck.drawCard())
        println("drawing card")
        return playCard(deck)
    }
}
