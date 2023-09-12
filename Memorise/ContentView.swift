//
//  ContentView.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            //the default value can be changed
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange) //default is to fill the background with orange too
        .padding()
    }
}

struct CardView: View{
    
    //a struct (var) must have a value
    var isFaceUp: Bool = false
    var body:some View{
        ZStack(content: {
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white) //overwrite the ground Colour on line 19
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("🫡").font(.largeTitle)
            } else{
                RoundedRectangle(cornerRadius: 12) // take orange colour from line 19
            }

        })
    }
}


// Produces a content view, has nothing to do with function building.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
