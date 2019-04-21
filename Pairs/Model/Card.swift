//
//  Card.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import Foundation


struct Card {
    
    private static var lastIdentifier = -1
    
    private static func getUniqueIdentifier() -> Int {
        lastIdentifier += 1
        return lastIdentifier
    }
    
    
    private var id: Int
    var isRevealed = false
    var isMatched = false

    
    init() {
        id = Card.getUniqueIdentifier()
    }
    
}


extension Card: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
}
