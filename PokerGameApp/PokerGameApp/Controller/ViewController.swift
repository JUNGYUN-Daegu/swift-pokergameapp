//
//  ViewController.swift
//  PokerGameApp
//
//  Created by 조중윤 on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {
    let game = PokerGame()
    
    lazy var studSelectSegmentedControl: UISegmentedControl = {
        let items = game.exportStudVariant()
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 5.0
        control.layer.masksToBounds = true
        control.layer.borderWidth = 1
        control.layer.borderColor = CGColor.init(gray: 1, alpha: 1)
        let font = UIFont.systemFont(ofSize: 15)
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: font
        ]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(selectStud(_:)), for: .valueChanged)
        return control
     }()
    
    lazy var numberOfPlayersSegmentedControl: UISegmentedControl = {
        let items = game.exportNumberOfPlayersOptions()
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.tintColor = UIColor.white
        control.layer.cornerRadius = 5.0
        control.layer.masksToBounds = true
        control.layer.borderWidth = 1
        control.layer.borderColor = .init(gray:1, alpha: 1)
        let font = UIFont.systemFont(ofSize: 15)
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: font
        ]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(selectNumberOfPlayers(_:)), for: .valueChanged)
        return control
     }()
    
    let verticalDashboardStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundPatternImage: UIImage = UIImage(named: "bg_pattern") ?? UIImage()
        let cardBacksideImage: UIImage = UIImage(named: "card-back") ?? UIImage()
        self.view.backgroundColor = UIColor(patternImage: backgroundPatternImage)
        
        self.view.addSubview(studSelectSegmentedControl)
        configureCardNumberSelectSegmentedControl()
        self.view.addSubview(numberOfPlayersSegmentedControl)
        configureNumberOfPlayersSegementedControl()
    }
    
    func gameInteration() {
        self.view.addSubview(verticalDashboardStackView)
        configureVerticalStackView()
        guard let gameResult = game.play() else { return }
        print(gameResult)
        generateGameDashBoard(with: gameResult)
    }
    
    func configureVerticalStackView() {
        verticalDashboardStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        verticalDashboardStackView.topAnchor.constraint(equalTo: self.numberOfPlayersSegmentedControl.bottomAnchor, constant: 5).isActive = true
        verticalDashboardStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width/20).isActive = true
        verticalDashboardStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -self.view.frame.width/20).isActive = true
        verticalDashboardStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: -self.view.frame.height/10).isActive = true
    }
    
    func configureNumberOfPlayersSegementedControl() {
        numberOfPlayersSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        numberOfPlayersSegmentedControl.topAnchor.constraint(equalTo: self.studSelectSegmentedControl.bottomAnchor, constant: 5).isActive = true
        numberOfPlayersSegmentedControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        numberOfPlayersSegmentedControl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func configureCardNumberSelectSegmentedControl() {
        studSelectSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        studSelectSegmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        studSelectSegmentedControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.33).isActive = true
        studSelectSegmentedControl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    func generateGameDashBoard(with game: Array<Array<Card>>) {
        for (index, participant) in game.enumerated() {
            var playerTag: String = ""
            if index == game.count-1 {
                playerTag = "Dealer"
            } else {
                playerTag = "Player\(index+1)"
            }
            verticalDashboardStackView.addArrangedSubview(makePlayerTagLabel(with: playerTag))
            verticalDashboardStackView.addArrangedSubview(makeindividuallCardStacks(with: participant, with: UIImage()))
        }
    }
    
    func makePlayerTagLabel(with name: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = name
        label.heightAnchor.constraint(equalToConstant: self.view.frame.height/30).isActive = true
        return label
    }
    
    func makeindividuallCardStacks(with cards: Array<Card>, with prizeImage: UIImage) -> UIStackView {
        let stackView = horizontalStackView()
        for card in cards {
            let newCardImageView = card.makeCardImageView()
            stackView.addArrangedSubview(newCardImageView)
        }
        let prizeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = prizeImage
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        stackView.heightAnchor.constraint(equalToConstant: self.view.frame.height/10).isActive = true
        stackView.addArrangedSubview(prizeImageView)
        return stackView
    }
    
    func horizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = -20
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }
    
    @objc func selectStud(_ sender: UISegmentedControl) {
        verticalDashboardStackView.removeFullyAllArrangedSubviews()
        game.selectStudVariant(index: sender.selectedSegmentIndex)
        gameInteration()
    }
    
    @objc func selectNumberOfPlayers(_ sender: UISegmentedControl) {
        verticalDashboardStackView.removeFullyAllArrangedSubviews()
        game.selectNumberOfPlayer(index: sender.selectedSegmentIndex)
        gameInteration()
    }
}
extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}
