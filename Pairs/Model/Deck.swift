//
//  Deck.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import Foundation


class Deck {
    
    private(set) var cards = [Card]()
    
    private var indexOfRevealedCard: Int? {
        get { return cards.indices.filter { cards[$0].isRevealed }.oneAndOnly }
        
        set { cards.indices.forEach { cards[$0].isRevealed = ($0 == newValue) } }
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
