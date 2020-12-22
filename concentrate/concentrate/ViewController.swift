//
//  ViewController.swift
//  concentrate
//
//  Created by Tae-Jin Oh on 2020/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var cards: [UIButton]!
    private lazy var myCards = Cards(cards.count)
    private lazy var matched = Array(repeating: false, count: cards.count)
    private var selectedCards = [Int]()
    private var pop2 = false
    private var numRemoved = 0
    private let bg = UIColor.systemBlue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    @IBAction private func selectCard(_ sender: Any) {
        for (ii, card) in cards.enumerated() {
            if card == sender as! NSObject && matched[ii] == false && !selectedCards.contains(ii) {
                showCard(ii)
                switch selectedCards.count {
                case 2:
                    if myCards.emojiCard[selectedCards[0]] == myCards.emojiCard[selectedCards[1]] {
                        matched[selectedCards[0]] = true
                        matched[selectedCards[1]] = true
                        pop2 = true
                        if numRemoved == myCards.numPairs*2-2 {
                            removeCard(selectedCards.removeFirst())
                            removeCard(selectedCards.removeFirst())
                            complete()
                        }
                    }
                case 3:
                    switch pop2 {
                    case true:
                        removeCard(selectedCards.removeFirst())
                        removeCard(selectedCards.removeFirst())
                        pop2 = false
                    case false:
                        hideCard(selectedCards.removeFirst())
                        hideCard(selectedCards.removeFirst())
                    }
                default:
                    break
                }
            }
        }
    }
    
    private func showCard(_ id: Int) {
        selectedCards.append(id)
        print(selectedCards)
        cards[id].setTitle(myCards.emojiCard[id], for: .normal)
        cards[id].backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        cards[id].titleLabel?.font =  UIFont(name: "Helvetica", size: 60)
    }
    
    private func hideCard(_ id: Int) {
        cards[id].backgroundColor = bg
        cards[id].setTitle("", for: .normal)
    }
    
    private func removeCard(_ id: Int) {
        cards[id].backgroundColor = UIColor(white: 0, alpha: 0)
        cards[id].setTitle("", for: .normal)
        numRemoved += 1
    }
    
    private func complete() {
        print("Congratulations!")
        newGame()
    }
    
    private func newGame() {
        myCards = Cards(cards.count)
        myCards.shuffleCards()
        matched = Array(repeating: false, count: cards.count)
        selectedCards = [Int]()
        cards.forEach {
            $0.backgroundColor = bg
        }
        pop2 = false
        numRemoved = 0
    }
}

