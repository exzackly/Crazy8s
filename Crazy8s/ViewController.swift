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
    var deck = Deck()
    let player = Player()
    let opponent = Opponent()
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playGame()
    }
    
    @IBAction func drawCard(sender: UIButton) {
        for card in player.hand {
            if cardIsValid(card).isValid {
                let drawAlert = UIAlertController(title: "Cannot Draw Card", message: "There is a valid move to be made", preferredStyle: .Alert)
                drawAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                presentViewController(drawAlert, animated: true, completion: nil)
                return
            }
        }
        player.hand.append(deck.drawCard())
        drawScreen()
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        drawScreen()
    }
    
    func gameOver() {
        for card in opponent.hand {
            if card.rank == 8 {player.score += 50}
            else if card.rank > 10 && card.rank < 14 {player.score += 10}
            else {player.score += card.rank}
        }
        for card in player.hand {
            if card.rank == 8 {opponent.score += 50}
            else if card.rank > 10 && card.rank < 14 {opponent.score += 10}
            else {opponent.score += card.rank}
        }
        let gameOverMessage = UIAlertController(title: "Game Over", message: "Player : \(player.score) | Opponent : \(opponent.score)", preferredStyle: .Alert)
        gameOverMessage.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: {_ in self.restartGame()}))
        presentViewController(gameOverMessage, animated: true, completion: nil)
    }
    
    func restartGame() {
        deck.discards[0].removeFromSuperview()
        deck = Deck()
        for card in player.hand {card.removeFromSuperview()}
        for card in opponent.hand {card.removeFromSuperview()}
        player.hand.removeAll()
        opponent.hand.removeAll()
        opponent.gameIsOver = false
        playGame()
    }
    
    func drawScreen() {
        println(deck)
        player.sortHand()
        if opponent.gameIsOver || player.hand.count == 0 {gameOver();return}
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
        gestureRecognizer.view?.center = CGPoint(x: (gestureRecognizer.view?.center)!.x + gestureRecognizer.translationInView(gestureRecognizer.view!).x, y: (gestureRecognizer.view?.center)!.y + gestureRecognizer.translationInView(gestureRecognizer.view!).y)
        gestureRecognizer.setTranslation(CGPointZero, inView: gestureRecognizer.view)
        if gestureRecognizer.state == .Ended {
            if CGRectContainsPoint(deck.discards[0].frame, gestureRecognizer.locationInView(view)) {
                if cardIsValid(gestureRecognizer.view as Card).isValid && cardIsValid(gestureRecognizer.view as Card).card.rank != 8 {deck.discardCard((gestureRecognizer.view as Card)); for (cardNum, cardTemp) in enumerate(player.hand) {if (gestureRecognizer.view as Card) == cardTemp {player.hand.removeAtIndex(cardNum)};}; (gestureRecognizer.view as Card).removeFromSuperview(); opponent.playCard(deck); drawScreen()}
                else if cardIsValid(gestureRecognizer.view as Card).isValid {deck.discardCard((gestureRecognizer.view as Card)); for (cardNum, cardTemp) in enumerate(player.hand) {if (gestureRecognizer.view as Card) == cardTemp {player.hand.removeAtIndex(cardNum)};}; (gestureRecognizer.view as Card).removeFromSuperview(); chooseSuit()}
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
        scoreLabel.text = "Player : \(player.score) | Opponent : \(opponent.score)"
        dealCards()
        drawScreen()
    }
    
    func chooseSuit() {
        if player.hand.count == 0 {drawScreen()}
        let chooseSuitAlert = UIAlertController(title: "Choose Suit", message: nil, preferredStyle: .ActionSheet)
        chooseSuitAlert.popoverPresentationController?.sourceRect = deck.discards[0].frame
        chooseSuitAlert.popoverPresentationController?.sourceView = view
        chooseSuitAlert.addAction(UIAlertAction(title: "♣ Clubs ♣", style: .Default, handler: {_ in self.deck.discards[0].text = "♣"; self.opponent.playCard(self.deck); self.drawScreen()}))
        chooseSuitAlert.addAction(UIAlertAction(title: "♦ Diamonds ♦", style: .Default, handler: {_ in self.deck.discards[0].text = "♦"; self.opponent.playCard(self.deck); self.drawScreen()}))
        chooseSuitAlert.addAction(UIAlertAction(title: "♥ Hearts ♥", style: .Default, handler: {_ in self.deck.discards[0].text = "♥"; self.opponent.playCard(self.deck); self.drawScreen()}))
        chooseSuitAlert.addAction(UIAlertAction(title: "♠ Spades ♠", style: .Default, handler: {_ in self.deck.discards[0].text = "♠"; self.opponent.playCard(self.deck); self.drawScreen()}))
        presentViewController(chooseSuitAlert, animated: true, completion: nil)
    }
    
    func cardIsValid(card: Card) -> (isValid: Bool, card: Card) {
        if card.rank == 8 {return (true, card)}
        else if countElements(deck.discards[0].text!) == 1 {
            if  "\(card.decodeSuit())" == deck.discards[0].text {return (true, card)}
            else {return (false, card)}
        }
        else if (card.rank == deck.discards[0].rank) || (card.suit == deck.discards[0].suit) {return (true, card)}
        else {return (false, card)}
    }
    
}



