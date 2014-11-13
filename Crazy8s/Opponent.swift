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
    
    func playCard(deck: Deck) -> (card: Card, suit: Int) {
        println("playing card")
        for (cardNum, card) in enumerate(hand) {
            if countElements(deck.discards[0].text!) == 1 {if  "\(card.decodeSuit())" == deck.discards[0].text && card.rank != 8 {deck.discardCard(card); return (hand.removeAtIndex(cardNum), card.suit)}}
            else if (card.rank == deck.discards[0].rank) || (card.suit == deck.discards[0].suit) && card.rank != 8 {deck.discardCard(card); return (hand.removeAtIndex(cardNum), card.suit)}
        }
        for (cardNum, card) in enumerate(hand) {
            if card.rank == 8 {
                println("playing 8")
                var suitCount: (clubs: Int, diamonds: Int, hearts: Int, spades: Int) = (0,0,0,0)
                for card in hand {
                    if card.rank != 8 {
                        if card.suit == 1 {suitCount.clubs++}
                        else if card.suit == 2 {suitCount.diamonds++}
                        else if card.suit == 3 {suitCount.hearts++}
                        else if card.suit == 4 {suitCount.spades++}
                    }
                }
                deck.discardCard(card);
                if suitCount.clubs == max(suitCount.clubs, suitCount.diamonds, suitCount.hearts, suitCount.spades) {deck.discards[0].text = "♣"; return (hand.removeAtIndex(cardNum), 1)}
                else if suitCount.diamonds == max(suitCount.clubs, suitCount.diamonds, suitCount.hearts, suitCount.spades) {deck.discards[0].text = "♦"; return (hand.removeAtIndex(cardNum), 2)}
                else if suitCount.hearts == max(suitCount.clubs, suitCount.diamonds, suitCount.hearts, suitCount.spades) {deck.discards[0].text = "♥"; return (hand.removeAtIndex(cardNum), 3)}
                else if suitCount.clubs == max(suitCount.clubs, suitCount.diamonds, suitCount.hearts, suitCount.spades) {deck.discards[0].text = "♠"; return (hand.removeAtIndex(cardNum), 4)}
                else {deck.discards[0].text = "♣"; return (hand.removeAtIndex(cardNum), 1)}
                 }
        }
        hand.append(deck.drawCard())
        println("drawing card")
        return playCard(deck)
    }
    
}
