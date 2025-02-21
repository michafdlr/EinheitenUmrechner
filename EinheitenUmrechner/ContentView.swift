//
//  ContentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftUI

struct BackgroundColorStyle: ViewModifier {
    func body(content: Content) -> some View {
        return ZStack {
            Color.mint.ignoresSafeArea()
            content
        }
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var categoriesSortedAscending = true
    @State private var angle = 0.0

    var sortedCategories: [Category] {
        if categoriesSortedAscending {
            return allCategories.sorted {
                String(localized: $0.text) < String(localized: $1.text)
            }
        }
        return allCategories.sorted {
            String(localized: $0.text) > String(localized: $1.text)
        }
    }

    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return sortedCategories
        }
        return sortedCategories.filter {
            String(localized: $0.text).localizedCaseInsensitiveContains(
                searchText.lowercased())
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                GridStack(categories: filteredCategories)
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationTitle("Convert Units")
            .toolbar {
                Button {
                    categoriesSortedAscending.toggle()
                    angle =
                        categoriesSortedAscending ? angle - 180 : angle + 180
                } label: {
                    Image(
                        systemName: "arrowshape.up.circle.fill"
                    )
                    .rotationEffect(Angle(degrees: angle))
                    .animation(
                        .bouncy(duration: 0.5, extraBounce: 0.3), value: angle
                    )
                    .font(.title)
                }
            }
            .animation(.easeIn(duration: 0.5), value: categoriesSortedAscending)
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Category")
    }
}

#Preview {
    ContentView()
}
