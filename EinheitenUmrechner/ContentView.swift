//
//  ContentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var searchText = ""
    @State private var categoriesSortedAscending = true
    @State private var angle = 0.0
    
    @Query var categoryNames: [CategoryName]

    var sortedCategories: [Category] {
        if categoriesSortedAscending {
            return allCategories.sorted {
                String(localized: $0.title) < String(localized: $1.title)
            }
        }
        return allCategories.sorted {
            String(localized: $0.title) > String(localized: $1.title)
        }
    }

    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return sortedCategories
        }
        return sortedCategories.filter {
            String(localized: $0.title).localizedStandardContains(
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
                SortButtonView(sortedAscending: $categoriesSortedAscending)
            }
            .animation(.easeIn(duration: 0.5), value: categoriesSortedAscending)
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search Category")
    }
}

#Preview {
    @Previewable @StateObject var networkMonitor = NetworkMonitor()
    ContentView()
        .environmentObject(networkMonitor)
//        .modelContainer(for: [CategoryName.self, Favorite.self], inMemory: true)
}
