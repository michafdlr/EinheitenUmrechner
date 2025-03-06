//
//  GridView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 13.02.25.
//

import SwiftUI

struct GridLabelView: View {
    var title: LocalizedStringResource
    var imageName: String
    var width: CGFloat  // Dynamically set width

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.caption)
                .bold()
                .multilineTextAlignment(.center)
            
            Image(systemName: imageName)
                .font(.title)
        }
        .padding()
        .frame(width: max(100, width), height: max(100, width)) // Keep square ratio
        .foregroundStyle(.white)
        .background(.accent)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

//#Preview {
//    GridItemView()
//}
