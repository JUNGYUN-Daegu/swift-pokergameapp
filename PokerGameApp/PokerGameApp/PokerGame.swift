//
//  PokerGame.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/17.
//

import Foundation

class PokerGame {
    public enum StudVariant {
        case fiveCardStud
        case sevenCardStud
    }

    private var cardDeck = CardDeck()
    private var dealer = Dealer()
    private var players: Players
    private var numberOfCards: Int
    private var lackOfCard: Bool = false
    
    public init(withPlayersOf: Int, stud: StudVariant) {
        players = Players(numberOfPlayers: withPlayersOf)
        numberOfCards = stud == .fiveCardStud ? 5 : 7
    }
    
    private func resetCardDeck() {
        cardDeck.reset()
        cardDeck.shuffle()
        print(cardDeck.count())
    }
    
    private func distribute() {
        for _ in 1...numberOfCards {
            players.cardForAll(cards: cardDeck)
            
            if let drawnCard = cardDeck.removeOne() {
                dealer.receive(card: drawnCard)
            } else {
                lackOfCard = true
                return
            }
        }
    }
    
    public func gamePlay() {
        resetCardDeck()
        distribute()
        if lackOfCard == true {
            print("카드 수 부족")
            return
        }
        print("\(players)")
        print("\(dealer)")
        print("\(cardDeck.count())")
    }
}

