//
//  Card.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import Foundation


struct Card {
    
    /*------------------------*/
    // MARK: Static Properties
    /*------------------------*/
    
    static var lastIdentifier = -1
    
    static func getUniqueIdentifier() -> Int {
        lastIdentifier += 1
        return lastIdentifier
    }
    
    
    /*--------------------------*/
    // MARK: Internal Properties
    /*--------------------------*/
    
    var id: Int
    var isRevealed = false
    var isMatched = false

    
    /*------------------*/
    // MARK: Initializer
    /*------------------*/
    
    init() {
        id = Card.getUniqueIdentifier()
    }
    
}
