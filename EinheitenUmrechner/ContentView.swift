//
//  ContentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var searchText = ""
    @State private var categoriesSortedAscending = true
    @State private var angle = 0.0
    @State private var searchIsActive = false

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
        GeometryReader { proxy in
            let layout = [
                GridItem(.adaptive(minimum: proxy.size.width / 4))
            ]
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: layout, alignment: .center, spacing: 20) {
                        ForEach(filteredCategories) { category in
                            NavigationLink {
                                category.view()
                            } label: {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.accent)
                                        .frame(minHeight: proxy.size.width / 4)
                                        .shadow(color: .gray, radius: 5)

                                    VStack(alignment: .center, spacing: 10) {
                                        Text(category.title)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 5)

                                        Image(systemName: category.imageName)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }

                        }
                    }
                    .padding(.horizontal, 20)
                }
                .navigationTitle("Convert Units")
                .toolbar {
                    SortButtonView(sortedAscending: $categoriesSortedAscending)

                    Button("Search Category", systemImage: "magnifyingglass.circle.fill")
                    {
                        searchIsActive = true
                    }
                }
                .animation(
                    .easeInOut(duration: 0.5), value: categoriesSortedAscending)
            }
            .searchable(
                text: $searchText,
                isPresented: $searchIsActive,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search Category")
        }
    }
}

#Preview {
    @Previewable @StateObject var networkMonitor = NetworkMonitor()
    ContentView()
        .environmentObject(networkMonitor)
}
