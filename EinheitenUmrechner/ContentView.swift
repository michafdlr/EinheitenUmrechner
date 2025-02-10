//
//  ContentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Länge", systemImage: "ruler") {
                LengthView()
            }
            
            Tab("Temperatur", systemImage: "thermometer.transmission") {
                Text("Temperatur")
            }
            
            Tab("Zeit", systemImage: "clock") {
                Text("Zeit")
            }
            
            Tab("Volumen", systemImage: "scalemass") {
                Text("Volumen")
            }
        }
    }
}

#Preview {
    ContentView()
}
