//
//  CardView.swift
//  Crazy8s
//
//  Created by EXZACKLY on 11/11/14.
//  Copyright (c) 2014 EXZACKLY. All rights reserved.
//

import UIKit

class CardView: UILabel {
    
    let cardOriginalCenter: CGRect!
    
    init(frame: CGRect, withCard: Card) {
        cardOriginalCenter = frame
        super.init(frame: frame)
        backgroundColor = UIColor.cyanColor()
        text = "\(withCard)"
        userInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "moveCard:"))
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func moveCard(gestureRecognizer: UIPanGestureRecognizer) {
        center = gestureRecognizer.locationInView(self.superview)
        if gestureRecognizer.state == .Ended {frame = cardOriginalCenter}
    }
    
}
