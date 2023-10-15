//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/25.
//

import SwiftUI //ViewModel needs to know about the UI

//Can have a global function, and when initialising model you will write:
//model = MemoryGame(numberOfPairsOfCards: 4, cardContentFactory: createCardContent)
/*func createCardContent(forPairAtIndex index: Int) -> String {
 return ["🀢","🀣","🀤","🀥","🀢","🀣","🀤","🀥","🀄️","🀆","🀦","🀧","🀨","🀩","🀄️","🀆","🀦","🀧","🀨","🀩"][index]
}*/

class EmojiMemoryGame: ObservableObject {
    
    struct Theme {
        let name: String
        let numberOfPairs: Int
        let colour: Color
        let emoji: [String]
    }
    
    //static: make emojis global but namespace it inside the class
    private static let Colour = Theme(name: "Colour", numberOfPairs: 9, colour: .yellow, emoji: ["🔴","🟡","🟢","🔵","🟣","🟤","🟠","⚪️","⚫️"]),
                
                Fruits = Theme(name: "Fruits", numberOfPairs: 11, colour: .green, emoji:["🍎","🍐","🍊","🍋","🍌","🍉","🍎","🍐","🍊","🍋","🍌","🍉","🫐","🍓","🫐","🍓","🍇","🍒","🍍","🍇","🍒","🍍"]),
                
                Mahjong = Theme(name: "Mahjong", numberOfPairs: 10, colour: .orange, emoji:["🀢","🀣","🀤","🀥","🀢","🀣","🀤","🀥","🀄️","🀆","🀦","🀧","🀨","🀩","🀄️","🀆","🀦","🀧","🀨","🀩"])
    
    private static let themeChosen = [Colour, Fruits, Mahjong][themeIndex]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex  in
            if (themeChosen.emoji.indices.contains(pairIndex))  {
                return (themeChosen.emoji[pairIndex]) //don't have to put the namespace of emojis at the front
            } else {
                return "?!"
            }
        } //call the model MemoryGame
    }
    
    //private: the var is private to the class. Access control to restrict UI talking directly to the model.
    //Otherwise UI can say viewModel.model and talk to the model directly.
    //@Published means something will change
    @Published private var model = createMemoryGame()

    
    //This is needed for the UI to work because model is now private.
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeIndex: Int {
        return model.themeIndex
    }
    
    //MARK: - Intents
    
    //_ makes the parameter name an internal name, so the caller won't see it.
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model.newGame()
    }
    
}
