//
//  GridStack.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 16.02.25.
//

import SwiftUI

struct GridStack: View {
    var categories: [Category]
    
    var rows: Int {
        (categories.count + 2) / 3 // Ensures rounding up correctly
    }

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let spacing: CGFloat = 20
            let itemWidth = (totalWidth - 4 * spacing) / 3  // 3 items per row with spacing
            
            ScrollView {
                VStack {
                    Grid(
                        alignment: .bottom,
                        horizontalSpacing: spacing,
                        verticalSpacing: spacing
                    ) {
                        ForEach(0..<rows, id: \.self) { i in
                            GridRow {
                                ForEach(0..<3, id: \.self) { j in
                                    if i * 3 + j < categories.count {
                                        NavigationLink {
                                            categories[i*3 + j].view()
                                        } label: {
                                            GridLabelView(
                                                title: categories[i*3 + j].title,
                                                imageName: categories[i*3 + j].imageName,
                                                width: itemWidth
                                            )
                                        }
                                    } else {
                                        Spacer() // Keeps columns aligned if row has fewer than 3 items
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, spacing)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

//#Preview {
//    GridStack()
//}
