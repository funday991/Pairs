//
//  Deck.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import UIKit


class Deck {
    
    /*--------------------------*/
    // MARK: Internal Properties
    /*--------------------------*/
    
    var cards = [Card]()
    var indexOfRevealedCard: Int?
    
    
    /*------------------*/
    // MARK: Initializer
    /*------------------*/
    
    init(numberOfPairs: Int) {
        for _ in 0..<numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
    }
    
    
    /*-----------------------*/
    // MARK: Internal Methods
    /*-----------------------*/
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched { return }
        
        if let matchIndex = indexOfRevealedCard, matchIndex != index {
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            
            turnCardsOver(withIndices: (index, matchIndex))
            
            indexOfRevealedCard = nil
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isRevealed = false
            }
            
            indexOfRevealedCard = index
        }
        
        cards[index].isRevealed = true
    }
    
    
    /*----------------------*/
    // MARK: Private Methods
    /*----------------------*/
    
    private func turnCardsOver(withIndices indices: (Int, Int)) {
        let (index1, index2) = indices
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cards[index1].isRevealed = false
            self.cards[index2].isRevealed = false
            
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
}
