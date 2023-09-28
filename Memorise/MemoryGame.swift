//
//  MemoriseGame.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/25.
//

import Foundation

struct MemoryGame<CardContent> { //<CardContent> is a don't care type for the entire struct. Leave for the UI to decide.
    private(set) var cards: Array<Card> //private (set) allows other code to see the var but not changing it.
    //Always start with private unless you know it has to be public straight away.
    
    //cardContentFactory is a function as type. Using this because we don't know what the CardContent is.
    //set up init so that when calling the model in ViewModel in a Class, the code does not complain
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    //This is an intent function
    func choose(_ card: Card) {
        
    }
    
    //Any function that can modify the model has to be marked mutating
    //This will cause a copy-on-write cuz something is changed
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card { //nested struct is good for name-spacing. This Card is going to be called MemoryGame.Card.
        var isFaceUp = true //faceup does change during the game
        var isMatched = false
        let content: CardContent //content doesn't change throughout the game
        
    }
    
}
