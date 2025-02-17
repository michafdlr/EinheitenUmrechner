//
//  ContentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID().uuidString
    let view: () -> AnyView
    let text: LocalizedStringResource
    let imageName: String
    
    init<V: View>(view: @escaping () -> V, text: LocalizedStringResource, imageName: String) {
            self.view = { AnyView(view()) }  // Wrap view in AnyView
            self.text = text
            self.imageName = imageName
        }
}

struct ContentView: View {
    @State private var searchText = ""
    
    let allCategories = [
        Category(view: {LengthView()}, text: "Length", imageName: "ruler.fill"),
        Category(view: {AreaView()}, text: "Area", imageName: "rectangle.inset.fill"),
        Category(view: {VolumeView()}, text: "Volume", imageName: "cube.fill"),
        Category(view: {MassView()}, text: "Mass", imageName: "scalemass.fill"),
        Category(view: {TemperatureView()}, text: "Temperature", imageName: "thermometer.sun.circle.fill"),
        Category(view: {Text("Time")}, text: "Time", imageName: "clock.fill"),
        Category(view: {Text("Currency")}, text: "Currency", imageName: "eurosign.circle.fill"),
    ]
    
    var filteredCategories: [Category] {
        if searchText.isEmpty {
            return allCategories
        }
        return allCategories.filter {
            String(localized: $0.text).localizedCaseInsensitiveContains(searchText.lowercased())
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
        }
        .searchable(text: $searchText, prompt: "Search Category")
    }
}

#Preview {
    ContentView()
}
