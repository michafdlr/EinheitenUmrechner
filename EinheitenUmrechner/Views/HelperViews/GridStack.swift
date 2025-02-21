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
        if categories.count < 3 {
            return 1
        }
        if categories.count.isMultiple(of: 3) {
            return categories.count / 3
        }
        return Int(categories.count / 3) + 1
    }

    var body: some View {
        ScrollView {
            Grid(
                alignment: .bottom, horizontalSpacing: 20,
                verticalSpacing: 20
            ) {
                Spacer()
                ForEach(0..<rows, id: \.self) { i in
                    GridRow {
                        ForEach(0..<3, id: \.self) { j in
                            if i * 3 + j < categories.count {
                                NavigationLink {
                                    categories[i*3 + j].view()
                                } label: {
                                    GridLabelView(
                                        title: categories[i*3 + j].text, imageName: categories[i*3 + j].imageName)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

//#Preview {
//    GridStack()
//}
