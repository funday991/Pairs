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
    
    private var emojiList: String!
    private var emojiDict: CardEmoji!
    
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
        emojiList = Constants.emojiList
        emojiDict = [Card: String]()
        
        updateCardButtons()
    }

    private func updateCardButtons() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = deck.cards[index]
            
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
        if emojiDict[card] == nil {
            let randomIndex = emojiList.index(emojiList.startIndex, offsetBy: emojiList.count.randomLessNumber)
            emojiDict[card] = String(emojiList.remove(at: randomIndex))
        }
        
        return emojiDict[card] ?? "?"
    }
    
    private func checkRemainingCards() {
        var hasUnmatchedCards = false
        
        for card in deck.cards where !card.isMatched {
            hasUnmatchedCards = true
            break
        }
        
        if !hasUnmatchedCards {
            self.gameBoard.isHidden = true
            self.newGameButton.isHidden = false
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
