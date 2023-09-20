//
//  ContentView.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/08.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: Array<String> = []
    
    @State var theme: String = ""
    
//@State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            title
            ScrollView {
                cards
            }
            Spacer()
            themeChoosingGroup
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorise!")
            .font(.largeTitle).bold().foregroundColor(.orange)
    }
    
    var themeChoosingGroup: some View{
        HStack{
            themeMahjong
            Spacer()
            themeColour
            Spacer()
            themeFruit
        }
    }
    
    func themeChoosing(content: [String], name: String, symbol: String) -> some View{
        Button(action: {
            emojis = content.shuffled()
            theme = name
        }, label: {
            VStack{
                Image(systemName: symbol).font(.largeTitle)
                Text(name)}
            .imageScale(.large)
        })
    }
    
    var themeMahjong: some View{
        themeChoosing(content: ["🀢","🀣","🀤","🀥","🀢","🀣","🀤","🀥","🀄️","🀆","🀦","🀧","🀨","🀩","🀄️","🀆","🀦","🀧","🀨","🀩"], name: "Mahjong", symbol: "lanyardcard")
    }
    
    var themeColour: some View{
        themeChoosing(content: ["🔴","🟡","🟢","🔵","🟣","🔴","🟡","🟢","🔵","🟣","🟤","🟠","⚪️","🟤","🟠","⚪️","⚫️","⚫️"], name: "Colour", symbol: "circle.inset.filled")
    }
    
    var themeFruit: some View{
        themeChoosing(content: ["🍎","🍐","🍊","🍋","🍌","🍉","🍎","🍐","🍊","🍋","🍌","🍉","🫐","🍓","🫐","🍓","🍇","🍒","🍍","🍇","🍒","🍍"], name: "Fruits", symbol: "carrot")
    }
    
    var cards: some View { //this is a normal function
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) { //this is a view builder
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content:emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange) //default is to fill the background with orange too
    }
    
//    var cards: some View { //this is a normal function
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) { //this is a view builder
//            ForEach(0..<cardCount, id: \.self) { index in
//                CardView(content:emojis[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//            }
//        }
//        .foregroundColor(.orange) //default is to fill the background with orange too
//    }
    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{ //by is what the caller uses; offset is the user-defined name, internal vs external parameter names. Symbol is both internal and external
//        Button(action: {
//                cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}

struct CardView: View {
    let content: String
    //a struct (var) must have a value
    @State var isFaceUp = false //have a default value, but value can change
    //@State stores a temporary state of the Var (by creating a pointer)
    
    var body: some View {
        ZStack { //trailing closure syntax - dont need a () because last/only argument is a function.
            let base = RoundedRectangle(cornerRadius: 12) //a View cannot be changed, so use let instead of var. Type Inference.
            Group {
                base.foregroundColor(.white) //overwrite the ground Colour on line 19
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1) //make the emojis transparent when face down so that the cards don't shrink - emojis are still there.

        }
        .onTapGesture {
            print("tapped") //a good debug feature to create something
            isFaceUp.toggle() //ifFaceUp is a Struct so it can have functions on it
        }
    }
}


// Produces a content view, has nothing to do with function building.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
