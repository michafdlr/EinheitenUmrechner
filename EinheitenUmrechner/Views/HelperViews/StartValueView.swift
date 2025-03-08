//
//  StartValueView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 15.02.25.
//

import SwiftUI

struct StartValueView<T: Dimension>: View {
    var textFieldName: String

    @FocusState.Binding var valueIsFocused: Bool
    @Binding var inputValue: Double
    @Binding var startUnit: T

    let allUnits: [T]

    var body: some View {
        //        HStack {
        HStack {
            GeometryReader { proxy in
                TextField(
                    textFieldName, value: $inputValue, format: .number,
                    prompt: Text("Your Value")
                )
                .textFieldStyle(.roundedBorder)
                .frame(width: proxy.size.width * 0.7)
                .keyboardType(.decimalPad)
                .focused($valueIsFocused)
            }

            Spacer()

            Text(startUnit.symbol)
                .bold()
        }
    }
}
