//
//  Players.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/17.
//

import Foundation

class Players {
    private var players: Array<Player> = []
    
    init(with numberOfPlayers: Int) {
        for sequence in 1...numberOfPlayers {
            players.append(Player(id: sequence))
        }
    }
    
    func cardForAll(cards: CardDeck) {
        for player in players {
            if let drawnCard = cards.removeOne() {
                player.receive(card: drawnCard)
            }
        }
    }
    
    //FIXME:- 이런 이렇게 정보를 주려하지말고(private 의미가 없어짐)-> 이 안에서 비교하는 로직을 짜기??
    func giveCardInfoOfPlayers() -> Array<Array<Card>> {
        var result: Array<Array<Card>> = []
        for player in players {
            result.append(player.cardInfo())
        }
        return result
    }
    
    public func resetPlayers() {
        players.forEach { (player) in
            player.resetPlayer()
        }
    }
}

extension Players: CustomStringConvertible {
    var description: String {
        var result = ""
        for player in players {
            result.append("\(player)\n")
        }
        return result
    }
}
