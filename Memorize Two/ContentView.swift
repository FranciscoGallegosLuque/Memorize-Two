//
//  ContentView.swift
//  Memorize Two
//
//  Created by Francisco Manuel Gallegos Luque on 28/03/2025.
//

import SwiftUI

struct Emojis {
    static let emojis = [
        ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙🏻", "🙀", "👹", "😱", "☠️", "🍭"],
        ["🥎", "🏈", "⚽️", "🏐", "🏓", "🎾", "🏉", "🏏", "🏀", "🏊🏾‍♀️", "🎿", "🏂"],
        ["🚗", "🚘", "🚙", "🚓", "🚔", "🚕", "🚖", "🏎️", "🚌", "🚎", "🚑", "🚞"],
    ]
}

struct ContentView: View {
    
    @State var cardCount: Int = 24
    @State var theme: [String] = Emojis.emojis[0]
    @State var emojis: [String] = (Emojis.emojis[0] + Emojis.emojis[0]).shuffled()
    
    var body: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(.bold)
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            themeSelectors
//            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                        .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }

    
    func emojisShuffler(_ emojis: [String]) -> [String] {
        (emojis + emojis).shuffled()
    }
    
    func selectorCreator(index: Int, symbol: String, caption: String) -> some View {
        Button {
            theme = Emojis.emojis[index]
            emojis = emojisShuffler(theme)
        } label: {
            VStack {
                Image(systemName: "\(symbol)")
                    .font(.title)
                Text("\(caption)")
                    .font(.subheadline)
            }
        }
    }
    
    var themeSelectors: some View {
        HStack(alignment: .bottom, spacing: 30) {
            vehiclesTheme
            sportsTheme
            halloweenTheme
        }
    }
    
    var vehiclesTheme: some View {
        selectorCreator(index: 2, symbol: "car", caption: "Vehicles")
    }
    
    var sportsTheme: some View {
        selectorCreator(index: 1, symbol: "football", caption: "Sports")
    }
    
    var halloweenTheme: some View {
        selectorCreator(index: 0, symbol: "moon", caption: "Halloween")
    }

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
}



#Preview {
    ContentView()
}

/*
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button {
//            cardCount += offset
//        } label: {
//            Image(systemName: symbol)
//        }
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }


    //    var cardRemover: some View {
    //        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    //    }
    //
    //    var cardAdder: some View {
    //        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    //    }
*/
