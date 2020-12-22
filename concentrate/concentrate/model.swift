//
//  model.swift
//  concentrate
//
//  Created by Tae-Jin Oh on 2020/12/22.
//

import Foundation

struct Cards {
    var emojiCard = Array("🍎🍐🍊🍌🍉🍇🥥🍑🍓🥝🍅🥑🌶🌽🥕🍗🍖🥨🍔🍟🍕🌮🍰🎂🍩🥐🦴⚽️🏀🏈⚾️🏓⛸🥌🎲🎻🎸🎳🚗🚑🚌🚚🛵🚲✈️").map{String($0)}
    let numPairs: Int
    init(_ numCards: Int) {
        numPairs = numCards/2
    }

    mutating func shuffleCards() {
        emojiCard.shuffle()
        emojiCard = Array(emojiCard[0..<numPairs] + emojiCard[0..<numPairs]).shuffled()
        emojiCard.shuffle()
    }
}
