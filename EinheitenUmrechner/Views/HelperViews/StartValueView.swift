//
//  StartValueView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 15.02.25.
//

import SwiftUI

struct StartValueView<T: Dimension>: View {
    var textFieldName: String
//    var textInputWidth: CGFloat
    
    @FocusState.Binding var valueIsFocused: Bool
    @Binding var inputValue: Double
    @Binding var startUnit: T
    
    let allUnits: [T]
    
    var body: some View {
        HStack {
            HStack {
                TextField(textFieldName, value: $inputValue, format: .number, prompt: Text("Your Value"))
                    .textFieldStyle(.roundedBorder)
//                    .frame(width: textInputWidth * 0.7)
                    .keyboardType(.decimalPad)
                    .focused($valueIsFocused)
                
                Text(startUnit.symbol)
                    .bold()
            }
            .containerRelativeFrame(.horizontal) { length, _ in
                return 0.65 * length
            }
//            .frame(width: textInputWidth, alignment: .topLeading)
            
            Divider()
            
            NavigationLink("Units") {
                UnitsView(selectedUnit: $startUnit, allUnits: allUnits)
            }
            .containerRelativeFrame(.horizontal) { length, _ in
                return 0.25 * length
            }
        }
    }
}
