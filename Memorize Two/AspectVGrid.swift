//
//  AspectVGrid.swift
//  Memorize Two
//
//  Created by Francisco Manuel Gallegos Luque on 03/05/2025.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
            func gridItemWidthThatFits(
                count: Int,
                size: CGSize,
                atAspectRatio aspectRatio: CGFloat
            ) -> CGFloat {
                print(count)
                let count = CGFloat(count)
                var columnCount = 1.0
                repeat {
                    let width = size.width / columnCount
                    let height = width / aspectRatio
                    
                    let rowCount = (count / columnCount).rounded(.up)
                    if rowCount * height < size.height {
                        print((size.width / columnCount).rounded(.down))
                        return (size.width / columnCount).rounded(.down)
                    }
                    columnCount += 1
                } while columnCount < count
                return min(size.width / count, size.height * aspectRatio).rounded(.down)
            }
}
