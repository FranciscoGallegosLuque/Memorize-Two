//
//  Memorize_TwoApp.swift
//  Memorize Two
//
//  Created by Francisco Manuel Gallegos Luque on 28/03/2025.
//

import SwiftUI

@main
struct Memorize_TwoApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
