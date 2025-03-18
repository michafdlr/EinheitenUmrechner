//
//  NoInternetView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 22.02.25.
//

import SwiftUI

struct NoInternetView: View {
    @EnvironmentObject var colors: colorManager
    
    var body: some View {
        VStack {
            Text("Error fetching Data")
                .foregroundStyle(.red)
                .font(.title)
                .bold()
                .padding(.top, 20)

            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .scaledToFit()
                .foregroundStyle(colors.accentColor)
                .frame(width: UIScreen.main.bounds.width * 0.5)
            
            
            Text("Please make sure you are connected to the internet!")
                .padding()
            Spacer()
//            ForEach(0..<4) { _ in
//                Spacer()
//            }
        }
    }
}

#Preview {
    NoInternetView()
}
