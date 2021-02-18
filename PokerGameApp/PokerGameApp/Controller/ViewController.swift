//
//  ViewController.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {
    var cardDeck = CardDeck()
    var game = PokerGame(withPlayersOf: .four, stud: .sevenCardStud)
    
    let dealerCardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundPatternImage: UIImage = UIImage(named: "bg_pattern") ?? UIImage()
        let cardBacksideImage: UIImage = UIImage(named: "card-back") ?? UIImage()
        
        self.view.backgroundColor = UIColor(patternImage: backgroundPatternImage)
        self.view.addSubview(dealerCardStackView)
        configureCardStackView(cardStackView: dealerCardStackView)
        guard let gameResult = game.play() else { return }
        print(gameResult)
        addSubviewToCardStackView(numberOfCards: 7, cards: gameResult[0])
    }
    
    func makeCardImageView(with card: Card) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        var cardInfoInCode: String {
            var result: String = ""
            switch card.suit {
            case .clovers: result.append("c")
            case .hearts: result.append("h")
            case .spades: result.append("s")
            case .diamonds: result.append("d")
            default: result.append("")
            }
            switch card.value {
            case .two: result.append("2")
            case .three: result.append("3")
            case .four: result.append("4")
            case .five: result.append("5")
            case .six: result.append("6")
            case .seven: result.append("7")
            case .eight: result.append("8")
            case .nine: result.append("9")
            case .ten: result.append("10")
            case .ace: result.append("A")
            case .jack: result.append("J")
            case .queen: result.append("Q")
            case .king: result.append("K")
            default: result.append("")
            }
            return result
        }
        imageView.image = UIImage(named: cardInfoInCode)
        return imageView
    }
    
    func configureCardStackView(cardStackView: UIStackView) {
        cardStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height/10).isActive = true
        cardStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cardStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    func addSubviewToCardStackView(numberOfCards: Int, cards: Array<Card>) {
        for card in cards {
            let newCardImageView = makeCardImageView(with: card)
            dealerCardStackView.addArrangedSubview(newCardImageView)
            newCardImageView.widthAnchor.constraint(equalTo: dealerCardStackView.heightAnchor, multiplier: 1/1.27).isActive = true
        }
    }
    
    func testScenario(command: String) {
            switch command {
            case "카드초기화": print("카드 전체를 초기화했습니다.");print("총\(cardDeck.count())장의 카드가 있습니다.")
            case "카드섞기": cardDeck.shuffle(); print("전체 \(cardDeck.count())장의 카드를 섞었습니다.")
            case "카드하나뽑기": print("\(cardDeck.removeOne()?.description ?? "뽑을 카드가 없습니다.")\n총 \(cardDeck.count())장의 카드가 남았습니다.")
            default: print("sdf")
        }
    }
}
    
