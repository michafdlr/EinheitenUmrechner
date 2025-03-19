//
//  SettingsView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 19.03.25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var colors: colorManager
    
    var body: some View {
            NavigationStack{
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .containerRelativeFrame([.horizontal, .vertical], alignment: .center) {length, axis in
                            if axis == .horizontal {
                                return 0.75 * length
                            }
                            return 0.2 * length
                        }
                        .foregroundStyle(colors.backgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(colors.accentColor, lineWidth: 5)
                        )
                        
                    Text("Preview Text")
                        .font(.title.bold())
                        .padding()
                        .background(colors.foregroundColor)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                List {
                    ColorPicker("Background Color", selection: $colors.backgroundColor)
                    ColorPicker("Accent Color", selection: $colors.accentColor)
                    ColorPicker("Grid Element Color", selection: $colors.foregroundColor)
                    ColorPicker("Text Color", selection: $colors.textColor)
                }
                .bold()
                .listRowSeparatorTint(colors.accentColor)
                .listRowSpacing(20)
//                .scrollContentBackground(.hidden)
//                .background(colors.backgroundColor)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Text("Settings")
                            .foregroundStyle(colors.textColor)
                            .bold()
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            dismiss()
                        }
                        .foregroundStyle(colors.accentColor)
                    }
                }
        }
    }
}
