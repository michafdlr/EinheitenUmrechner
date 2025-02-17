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
    
    var frameWidth: CGFloat {
        UIScreen.main.bounds.width / 3 * 0.8
    }
    var frameHeight: CGFloat {
        min(UIScreen.main.bounds.height / 6, frameWidth)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .bold()
            Image(systemName: imageName)
                .font(.title)
        }
        .frame(width: frameWidth, height: frameHeight)
        .foregroundStyle(.white)
        .background(.accent)
        .clipShape(.rect(cornerRadius: 20.0))
        .shadow(radius: 5)
    }
}

//#Preview {
//    GridItemView()
//}
