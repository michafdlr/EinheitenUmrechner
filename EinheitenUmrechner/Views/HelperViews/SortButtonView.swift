//
//  SortButtonView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 23.02.25.
//

import SwiftUI

struct SortButtonView: View {
    @Binding var sortedAscending: Bool
    @State private var angle = 0.0
    
    var body: some View {
        Button {
            sortedAscending.toggle()
            angle =
            sortedAscending ? angle - 180 : angle + 180
        } label: {
            Image(
                systemName: "arrowshape.up.circle.fill"
            )
            .rotationEffect(Angle(degrees: angle))
            .animation(
                .bouncy(duration: 0.5, extraBounce: 0.3), value: angle
            )
//            .font(.title)
        }
    }
}

//#Preview {
//    SortButtonView()
//}
