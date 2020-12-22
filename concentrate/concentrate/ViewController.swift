//
//  ViewController.swift
//  concentrate
//
//  Created by Tae-Jin Oh on 2020/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cards: [UIButton]!
    var myCards = Cards()
    lazy var matched = Array(repeating: false, count: myCards.numPairs*2)
    var selectedCards = [Int]()
    var pop2 = false
    var numRemoved = 0
    let bg = UIColor.systemBlue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    @IBAction func selectCard(_ sender: Any) {
        for (ii, card) in cards.enumerated() {
            if card == sender as! NSObject && matched[ii] == false {
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
    
    func showCard(_ id: Int) {
        selectedCards.append(id)
        print(selectedCards)
        cards[id].setTitle(myCards.emojiCard[id], for: .normal)
        cards[id].backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        cards[id].titleLabel?.font =  UIFont(name: "Helvetica", size: 60)
    }
    
    func hideCard(_ id: Int) {
        cards[id].backgroundColor = bg
        cards[id].setTitle("", for: .normal)
    }
    
    func removeCard(_ id: Int) {
        cards[id].backgroundColor = UIColor(white: 0, alpha: 0)
        cards[id].setTitle("", for: .normal)
        numRemoved += 1
    }
    
    func complete() {
        print("Congratulations!")
        newGame()
    }
    
    func newGame() {
        myCards = Cards()
        myCards.shuffleCards()
        matched = Array(repeating: false, count: myCards.numPairs*2)
        selectedCards = [Int]()
        cards.forEach {
            $0.backgroundColor = bg
        }
        pop2 = false
        numRemoved = 0
    }
}

