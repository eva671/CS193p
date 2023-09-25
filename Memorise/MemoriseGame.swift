//
//  MemoriseGame.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/25.
//

import Foundation

struct MemoryGame<CardContent> { //<CardContent> is a don't care type for the entire struct. Leave for the UI to decide.
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card { //nested struct is good for name-spacing. This Card is going to be called MemoryGame.Card.
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
    }
    
}
