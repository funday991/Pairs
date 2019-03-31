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
    
    func chooseCard(at index: Int, _ cardButtons: [UIButton]) {
        if cards[index].isMatched { return }
        
        if let matchIndex = indexOfRevealedCard, matchIndex != index {
            UIView.transition(with: cardButtons[index], duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            
            turnCardsOver(withIndices: (index, matchIndex), cardButtons)
            
            indexOfRevealedCard = nil
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isRevealed = false
            }
            
            UIView.transition(with: cardButtons[index], duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            indexOfRevealedCard = index
        }
        
        cards[index].isRevealed = true
    }
    
    
    /*----------------------*/
    // MARK: Private Methods
    /*----------------------*/
    
    private func turnCardsOver(withIndices indices: (Int, Int), _ cardButtons: [UIButton]) {
        let (index1, index2) = indices
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cards[index1].isRevealed = false
            self.cards[index2].isRevealed = false
            
            UIView.transition(with: cardButtons[index1], duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            UIView.transition(with: cardButtons[index2], duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
}
