//
//  Player.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/11/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

class Player: NSObject, PPlayer, Printable {
    var score = 0
    var hand = [Card]()
    var cardButtons = [UIButton]()
    
    override var description: String {
        var returnString = "Player: \(hand.count) cards\n"
        for card in hand {
            returnString += "\(card)\n"
        }
        return returnString
    }
    
}
