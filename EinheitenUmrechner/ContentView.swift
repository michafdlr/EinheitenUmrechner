//
//  ContentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//
import StoreKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @AppStorage("numberOfLaunches") private var numberOfLaunches = 0
    @EnvironmentObject var colors: colorManager
    @Environment(\.requestReview) private var requestReview
//    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var searchText = ""
    @State private var categoriesSortedAscending = true
    @State private var angle = 0.0
    @State private var searchIsActive = false
    @State private var settingsShowing = false
    @State private var tappedID: String?

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
                        ForEach(filteredCategories, id: \.id) { category in
                            NavigationLink {
                                category.view()
                            } label: {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(colors.foregroundColor)
                                        .frame(minHeight: proxy.size.width / 4)
                                        .shadow(color: colors.accentColor, radius: 2)

                                    VStack(alignment: .center, spacing: 10) {
                                        Text(category.title)
                                            .font(.headline)
                                            .foregroundStyle(colors.textColor)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 5)

                                        Image(systemName: category.imageName)
                                            .font(.headline)
                                            .foregroundStyle(colors.textColor)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .id(filteredCategories.map(\.id).hashValue)
                }
                .background(colors.backgroundColor)
//                .navigationTitle("Convert Units")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Convert Units")
                            .foregroundStyle(colors.textColor)
                            .font(.headline)
                            .bold()
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        SortButtonView(sortedAscending: $categoriesSortedAscending)

                        Button("Search Category", systemImage: "magnifyingglass.circle.fill")
                        {
                            searchIsActive = true
                        }
                        
                        Button("Settings", systemImage: "gearshape.fill") {
                            settingsShowing = true
                        }
                    }
                }
                .animation(
                    .easeInOut(duration: 0.5), value: categoriesSortedAscending)
                .sheet(isPresented: $settingsShowing) {
                    SettingsView()
                }
            }
            .onAppear {
                if numberOfLaunches > 0 && numberOfLaunches.isMultiple(of: 20) {
                    requestReview()
                }
            }
            .searchable(
                text: $searchText,
                isPresented: $searchIsActive,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search Category")
        }
    }
}

//#Preview {
//    @Previewable @StateObject var networkMonitor = NetworkMonitor()
//    ContentView()
//        .environmentObject(networkMonitor)
//}
