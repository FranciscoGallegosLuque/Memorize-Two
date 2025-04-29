//
//  Assignment1View.swift
//  Memorize Two
//
//  Created by Francisco Manuel Gallegos Luque on 29/04/2025.
//

import SwiftUI

import SwiftUI

struct Assignment1View: View {
    var carsEmojis = ["🚗", "🚙", "🚕", "🚓", "🚘", "🚖", "🏎️", "🚔"]
    var sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏"]
    var halloweenEmojis = ["💀", "🎃", "🕷️", "😈", "☠️", "🕸️", "🧙‍♀️", "🙀"]
    
    @State var emojis: [String] = []
    @State var color: Color = Color.black

    var body: some View {
        title
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            themeSelectors
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!").font(.largeTitle).fontWeight(.bold)
    }
    
    var themeSelectors: some View {
        HStack(alignment: .bottom, spacing: 50){
            themeButton(symbol: "car", caption: "Vehicles", selectedEmojis: carsEmojis, selectedColor: Color.red)
            themeButton(symbol: "baseball", caption: "Sports", selectedEmojis: sportsEmojis, selectedColor: Color.green)
            themeButton(symbol: "moon", caption: "Halloween", selectedEmojis: halloweenEmojis, selectedColor: Color.black)
        }
        .foregroundStyle(color)
    }
    
    func themeButton(symbol: String, caption: String, selectedEmojis: [String], selectedColor: Color) -> some View {
        Button {
            emojis = Array(selectedEmojis.shuffled()[0..<randomGenerator(range: 2...selectedEmojis.count)])
            emojis = (emojis + emojis).shuffled()
            color = selectedColor
        } label: {
            VStack(spacing: 6) {
                Image(systemName: symbol).font(.title)
                Text(caption).font(.caption2)
            }
        }
    }
    
    func randomGenerator (range: ClosedRange<Int>) -> Int {
        Int.random(in: range)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(emojis.indices, id: \.self) { index in
                Assignment1CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(color)
    }
}

       
struct Assignment1CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        })
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    Assignment1View()
}

