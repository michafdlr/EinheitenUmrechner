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
        Text(
            measureFormatter.string(from: targetUnit) == targetUnit.symbol
                ? "\(targetValue.value.formatted()) \(targetUnit.symbol)"
                : "\(targetValue.value.formatted()) \(measureFormatter.string(from: targetUnit).localizedCapitalized) (\(targetUnit.symbol))"
        )
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
