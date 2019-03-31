//
//  MainViewController.swift
//  Pairs
//
//  Created by Yury on 29/03/2019.
//  Copyright © 2019 Yury Buslovsky. All rights reserved.
//

import UIKit


/*********************************************************************************************************************************/
// MARK: - Base
/*********************************************************************************************************************************/

class MainViewController: UIViewController {
    
    /*----------------*/
    // MARK: IBOutlets
    /*----------------*/

    @IBOutlet weak var gameBoard: UIStackView!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    
    
    /*-------------------------*/
    // MARK: Private Properties
    /*-------------------------*/
    
    private var deck: Deck!
    
    private var emojiList: [String]!
    private var emojiDict: [Int: String]!
    
    
    /*----------------*/
    // MARK: Lifecycle
    /*----------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame()
    }
    
}


/*********************************************************************************************************************************/
// MARK: - Private Methods
/*********************************************************************************************************************************/

extension MainViewController {
    
    private func newGame() {
        gameBoard.isHidden = false
        newGameButton.isHidden = true
        
        deck = Deck(numberOfPairs: cardButtons.count / 2)
        emojiList = Constants.emojiList
        emojiDict = [Int: String]()
        
        deck.cards.shuffle()
        
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
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0) : #colorLiteral(red: 0.1605540514, green: 0.6665392518, blue: 0.7524924874, alpha: 1)
            }
        }
    }
    
    private func getEmoji(for card: Card) -> String {
        let emojiAmount = emojiList.count
        
        if emojiDict[card.id] == nil, emojiAmount > 0 {
            let randomIndex = Int.random(in: 0..<emojiAmount)
            emojiDict[card.id] = emojiList.remove(at: randomIndex)
        }
        
        return emojiDict[card.id] ?? "?"
    }
    
    private func checkRemainingCards() {
        var hasUnmatchedCards = false
        
        for card in self.deck.cards where !card.isMatched {
            hasUnmatchedCards = true
            break
        }
        
        if !hasUnmatchedCards {
            self.gameBoard.isHidden = true
            self.newGameButton.isHidden = false
        }
    }
    
}


/*********************************************************************************************************************************/
// MARK: - IBActions
/*********************************************************************************************************************************/

extension MainViewController {
    
    @IBAction func cardButtonTapped(_ sender: UIButton) {
        guard let cardIndex = cardButtons.firstIndex(of: sender) else { fatalError("Unknown card.") }
        
        deck.chooseCard(at: cardIndex, cardButtons)
        updateCardButtons()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateCardButtons()
            self.checkRemainingCards()
        }
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        newGame()
    }
    
}
