//
//  Card.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/16.
//

import Foundation

struct Card {
    enum Suit: Character, CaseIterable {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clovers = "☘️"
    }
    
    enum Value: String, CaseIterable {
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case jack = "J"
        case queen = "Q"
        case king = "K"
        case ace = "A"
    }

    public let suit: Suit, value: Value
    
    public func exportSuitAndValueInString() -> String {
        var suitString: String = ""
        switch self.suit {
                    case .clovers: suitString = "c"
                    case .hearts: suitString = "h"
                    case .spades: suitString = "s"
                    case .diamonds: suitString = "d"
                    }
        return "\(suitString)\(value.rawValue)"
    }
}


extension Card.Suit: CustomStringConvertible {
    var description: String {
        return "\(self.rawValue)"
    }
}

extension Card.Value: CustomStringConvertible {
    var description: String {
        return "\(self.rawValue)"
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return "\(self.suit)\(self.value)"
    }
}
