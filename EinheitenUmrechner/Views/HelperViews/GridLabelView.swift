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
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.accent)
                .frame(width: max(50, width), height: max(50, width))
                .shadow(color: .gray, radius: 5)

            GeometryReader { proxy in
                VStack(alignment: .center, spacing: 10) {
                    Text(title)
                        .font(.system(size: proxy.size.width * 0.15))
                        .foregroundStyle(.white)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 5)

                    Image(systemName: imageName)
                        .font(.system(size: proxy.size.width * 0.2))
                        .foregroundStyle(.white)
                }
                .frame(
                    width: proxy.size.width, height: proxy.size.height,
                    alignment: .center)
            }
        }
        //        .padding()
        //        .frame(width: max(100, width), height: max(100, width)) // Keep square ratio
        //        .foregroundStyle(.white)
        //        .background(.accent)
        //        .clipShape(RoundedRectangle(cornerRadius: 20))
        //        .shadow(color: .secondary, radius: 5)
    }
}

//#Preview {
//    GridItemView()
//}
