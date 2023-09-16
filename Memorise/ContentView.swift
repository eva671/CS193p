//
//  ContentView.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/08.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🫡","🥹","😤","🥲"]
    
    var body: some View {
        HStack{
            ForEach(emojis.indices, id: \.self) { index in 
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange) //default is to fill the background with orange too
        .padding()
    }
}

struct CardView: View {
    let content: String
    //a struct (var) must have a value
    @State var isFaceUp = true //have a default value, but value can change
    //@State stores a temporary state of the Var (by creating a pointer)
    
    var body: some View {
        ZStack { //trailing closure syntax - dont need a () because last/only argument is a function.
            let base = RoundedRectangle(cornerRadius: 12) //a View cannot be changed, so use let instead of var. Type Inference.
            if isFaceUp{
                base.foregroundColor(.white) //overwrite the ground Colour on line 19
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill() // take orange colour from line 19
            }

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
