//
//  Deck.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import UIKit


class Deck {
    
    var cards = [Card]()
    
    private var indexOfRevealedCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isRevealed }.oneAndOnly
        }
        
        set {
            for index in cards.indices {
                cards[index].isRevealed = index == newValue
            }
        }
    }
    
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched { return }
        
        if let matchIndex = indexOfRevealedCard, matchIndex != index {            
            if cards[matchIndex] == cards[index] {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            
            cards[index].isRevealed = true
        } else {
            indexOfRevealedCard = index
        }
    }
    
}
