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
        playGame()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        drawScreen()
    }
    
    func drawScreen() {
        if !deck.discards.isEmpty {if deck.discards[0].superview != nil {deck.discards[0].removeFromSuperview()}}
        for card in player.hand {card.removeFromSuperview()}
        
        //Draw Top of Discard
        if !deck.discards.isEmpty {
            deck.discards[0].frame = CGRect(x: (view.bounds.width/2) - view.bounds.width/8, y: 30, width: view.bounds.width/4, height: (view.bounds.height / 4) - 20)
            view.addSubview(deck.discards[0])
        }
        
        //Draw player cards
        let cardsPerRow = CGFloat(player.hand.count/2+player.hand.count%2)
        let cardWidth = (view.bounds.width / cardsPerRow) - 13
        let cardHeight = (view.bounds.height / 4) - 20
        for (cardNum, card) in enumerate(player.hand) {
            let rowTemp = (cardNum/Int(cardsPerRow))+1
            let columnTemp = (cardNum-(Int(cardsPerRow)*(rowTemp-1)))+1
            card.frame = CGRect(x: (cardWidth*CGFloat(columnTemp-1)) + CGFloat(10*columnTemp), y: (view.bounds.height-(cardHeight*CGFloat(rowTemp)) - (CGFloat(10*rowTemp))), width: cardWidth, height: cardHeight)
            card.originalFrame = card.frame
            card.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "moveCard:"))
            view.addSubview(card)
        }
    }
    
    func moveCard(gestureRecognizer: UIPanGestureRecognizer) {
        gestureRecognizer.view?.center = gestureRecognizer.locationInView(view)
        if gestureRecognizer.state == .Ended {
            if CGRectContainsPoint(deck.discards[0].frame, gestureRecognizer.locationInView(view)) {
                if cardIsValid(gestureRecognizer.view as Card) {println("valid")}
                else {gestureRecognizer.view?.frame = (gestureRecognizer.view as Card).originalFrame}
            } else {
                gestureRecognizer.view?.frame = (gestureRecognizer.view as Card).originalFrame
            }
        }
    }
    
    func dealCards() {
        for var temp = 0; temp != 8; temp++ {
            player.hand.append(deck.drawCard())
            opponent.hand.append(deck.drawCard())
        }
        deck.discardCard(deck.drawCard())
    }
    
    func playGame() {
        dealCards()
        drawScreen()
    }
    
    func chooseSuit() {
        let chooseSuitAlert = UIAlertController(title: "Choose Suit", message: nil, preferredStyle: .ActionSheet)
        chooseSuitAlert.addAction(UIAlertAction(title: "♣ Clubs ♣", style: .Default, handler: {_ in self.deck.discards[0].text = "♣"}))
        chooseSuitAlert.addAction(UIAlertAction(title: "♦ Diamonds ♦", style: .Default, handler: {_ in self.deck.discards[0].text = "♦"}))
        chooseSuitAlert.addAction(UIAlertAction(title: "♥ Hearts ♥", style: .Default, handler: {_ in self.deck.discards[0].text = "♥"}))
        chooseSuitAlert.addAction(UIAlertAction(title: "♠ Spades ♠", style: .Default, handler: {_ in self.deck.discards[0].text = "♠"}))
        presentViewController(chooseSuitAlert, animated: true, completion: nil)
    }
    
    func cardIsValid(card: Card) -> Bool {
        if card.rank == 8 {chooseSuit(); return true}
        else if countElements(deck.discards[0].text!) == 1 {
            if  "\(card.decodeSuit())" == deck.discards[0].text {return true}
            else {return false}
        }
        else if (card.rank == deck.discards[0].rank) || (card.suit == deck.discards[0].suit) {return true}
        else {return false}
    }
    
}



