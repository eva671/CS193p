//
//  MemoriseGame.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { //<CardContent> is a don't care type for the entire struct. Leave for the UI to decide.
    private(set) var cards: Array<Card> //private (set) allows other code to see the var but not changing it.
    //always start with private unless you know it has to be public straight away.
    
    //cardContentFactory is a function as type. Using this because we don't know what the CardContent is.
    //set up init so that when calling the model in ViewModel in a Class, the code does not complain
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    //data structure - we need the index of the one and only face up card. When we have that index, we can try to match it; else, flip all the cards back face down, except for the one that is just clicked.
    //make this index a computed property to make the algorithm less prone to error
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //get the index of the card that is face up; and return if only one value (added only as an extension to the Array.
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        //set all other cards to be faced down
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    //This is an intent function
    mutating func choose(_ card: Card) {
        //if can let chosenIndex be an int, do this; else, do nothing
        /* if let chosenIndex = index(of:card) { */
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    //return an optional. If index is found, return an int; else, return nil.
   /* private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    } */
    
    //Any function that can modify the model has to be marked mutating
    //This will cause a copy-on-write cuz something is changed
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        //nested struct is good for name-spacing. This Card is going to be called MemoryGame.Card.
        var isFaceUp = false //faceup does change during the game
        var isMatched = false
        let content: CardContent //content doesn't change throughout the game
        
        var id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up": "down")\(isMatched ? "matched" : "")"
        }
        
    }
    
}

extension Array {
    var only: Element? {
         count == 1 ? first : nil
    }
}
