//
//  Dealer.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/17.
//

import Foundation

class Dealer {
    private var cardDeck: Array<Card>
    
    init() {
        self.cardDeck = []
    }
    
    public func receive(card: Card) {
        cardDeck.append(card)
    }
}

extension Dealer: CustomStringConvertible {
    var description: String {
        return "딜러 \(cardDeck)"
    }
}
