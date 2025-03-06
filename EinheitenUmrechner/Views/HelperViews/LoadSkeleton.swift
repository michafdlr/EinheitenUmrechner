//
//  LoadSkeletonView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 02.03.25.
//

import SwiftUI

struct LoadSkeleton: ViewModifier {
    @State private var blinking = false
    let duration: Double

    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.2 : 1)
            .animation(
                .easeInOut(duration: duration).repeatForever(autoreverses: true), value: blinking
            )
            .onAppear {
                blinking.toggle()
            }
    }
}

extension View {
    func blinking(duration: Double = 0.75) -> some View {
        modifier(LoadSkeleton(duration: duration))
    }
}

struct LoadSkeletonView: View {
    let skeletonColor = Color(.init(gray: 0.8, alpha: 1))
    
    var body: some View {
        HStack {
            Text("Loading...")

            Spacer()

            skeletonColor
                .frame(width: 50, height: 30)
                .clipShape(.rect(cornerRadius: 5))
        }
    }
}
