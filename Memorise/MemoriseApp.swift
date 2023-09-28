//
//  MemoriseApp.swift
//  Memorise
//
//  Created by Eva Liu on 2023/09/08.
//

import SwiftUI

@main
struct MemoriseApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
