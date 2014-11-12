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
    var cardButtons = [CardView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dealCards()
        drawScreen()
        println(player)
        println(opponent)
        println(deck)
    }
    
    func drawScreen() {
        cardButtons.removeAll()
        
        //Draw Top of Discard
        let discardPileTop = UIView(frame: CGRect(x: (view.bounds.width/2) - view.bounds.width/8, y: 30, width: view.bounds.width/4, height: (view.bounds.height / 4) - 20))
        discardPileTop.backgroundColor = UIColor.cyanColor()
        view.addSubview(discardPileTop)
        
        //Draw player cards
        let buttonsPerRow = CGFloat(player.hand.count/2+player.hand.count%2)
        let cardWidth = (view.bounds.width / buttonsPerRow) - 13
        let cardHeight = (view.bounds.height / 4) - 20
        for var rowTemp = 1; rowTemp != 3; rowTemp++ {
            for var columnTemp = 1; columnTemp <= Int(buttonsPerRow); columnTemp++ {
                let newCardView = CardView(frame: CGRect(x: (cardWidth*CGFloat(columnTemp-1)) + CGFloat(10*columnTemp), y: (view.bounds.height-(cardHeight*CGFloat(rowTemp)) - (CGFloat(10*rowTemp))), width: cardWidth, height: cardHeight), withCard: player.hand[cardButtons.count])
                cardButtons.append(newCardView)
            }
        }
        for button in cardButtons {view.addSubview(button)}
    }
    
    func dealCards() {
        for var temp = 0; temp != 8; temp++ {
            player.hand.append(deck.drawCard())
            opponent.hand.append(deck.drawCard())
        }
    }
    
}

