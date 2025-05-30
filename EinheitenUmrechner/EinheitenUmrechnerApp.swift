//
//  EinheitenUmrechnerApp.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import StoreKit
import SwiftData
import SwiftUI

@main
struct EinheitenUmrechnerApp: App {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch = true
    @AppStorage("numberOfLaunches") private var numberOfLaunches = 0
//    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var colors = colorManager()
    @Environment(\.requestReview) var requestReview
    
    private var modelContainer: ModelContainer {
        if let container = CategoriesContainer.createCategories(shouldCreateDefault: &isFirstTimeLaunch) {
                return container
            } else {
                // Handle the failure: Fallback to an empty container
                print("Failed to create ModelContainer, using fallback.")
                return try! ModelContainer(for: Schema([CategoryName.self, Favorite.self, FavoriteCurrency.self]))
            }
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(colors.accentColor)
                .preferredColorScheme(.dark)
                .foregroundStyle(colors.textColor)
        }
        .environmentObject(colors)
        .modelContainer(modelContainer)
    }
    
    init() {
//        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        numberOfLaunches += 1
    }
}
