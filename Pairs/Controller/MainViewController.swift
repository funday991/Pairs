//
//  MainViewController.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import UIKit


typealias CardEmoji = [Card: String]


class MainViewController: UIViewController {

    @IBOutlet private weak var gameBoard: UIStackView!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    
    
    private var deck: Deck!
    
    private var availableEmojis: String!
    private var emojiForCard: CardEmoji!
    
    private var numberOfPairs: Int {
        return cardButtons.count / 2
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame()
    }
    
}


extension MainViewController {
    
    private func newGame() {
        gameBoard.isHidden = false
        newGameButton.isHidden = true
        
        deck = Deck(numberOfPairs: numberOfPairs)
        availableEmojis = Constants.availableEmojis
        emojiForCard = [:]
        
        updateCardButtons()
    }

    private func updateCardButtons() {
        cardButtons.indices.forEach {
            let button = cardButtons[$0]
            let card = deck.cards[$0]
            
            if card.isRevealed {
                button.setTitle(getEmoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.975376904, green: 0.8505949378, blue: 0.5487614274, alpha: 1)
            } else {
                button.setTitle(nil, for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0) : #colorLiteral(red: 0.1605540514, green: 0.6665392518, blue: 0.7524924874, alpha: 1)
            }
        }
    }
    
    private func getEmoji(for card: Card) -> String {
        if emojiForCard[card] == nil {
            let randomIndex = availableEmojis.index(availableEmojis.startIndex, offsetBy: availableEmojis.count.randomLessNumber)
            emojiForCard[card] = String(availableEmojis.remove(at: randomIndex))
        }
        
        return emojiForCard[card] ?? "?"
    }
    
    private func checkRemainingCards() {
        if deck.cards.filter({ !$0.isMatched }).isEmpty {
            gameBoard.isHidden = true
            newGameButton.isHidden = false
        }
    }
    
}


extension MainViewController {
    
    @IBAction private func cardButtonTapped(_ sender: UIButton) {
        guard let cardIndex = cardButtons.firstIndex(of: sender) else { fatalError("Unknown card.") }
        
        deck.chooseCard(at: cardIndex)
        updateCardButtons()
        
        checkRemainingCards()
    }
    
    @IBAction private func newGameButtonTapped(_ sender: UIButton) {
        newGame()
    }
    
}
