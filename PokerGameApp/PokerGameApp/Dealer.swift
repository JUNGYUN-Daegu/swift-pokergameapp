//
//  Dealer.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/17.
//

import Foundation

class Dealer {
    private var cardsInHand: Array<Card>
    
    init() {
        cardsInHand = []
    }
    public func receive(card: Card) {
        cardsInHand.append(card)
    }
}

extension Dealer: CustomStringConvertible {
    var description: String {
        return "딜러 \(cardsInHand)"
    }
}
