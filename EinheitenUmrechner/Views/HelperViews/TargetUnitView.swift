//
//  TargetUnitView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 15.02.25.
//

import SwiftUI

struct TargetUnitView<T: Dimension>: View {
    var targetValue: Measurement<T>
    var textInputWidth: CGFloat
    @Binding var targetUnit: T
    
    let allUnits: [T]
    
    var body: some View {
        HStack {
            Text(
                "\(targetValue.value.formatted()) \(targetUnit.symbol)"
            )
            .multilineTextAlignment(.trailing)
            .bold()
            .frame(width: textInputWidth, alignment: .topLeading)
            
            
            Divider()
            
            NavigationLink("Units") {
                UnitsView(selectedUnit: $targetUnit, allUnits: allUnits)
            }
        }
    }
}
