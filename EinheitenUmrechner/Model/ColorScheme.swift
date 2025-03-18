//
//  ColorScheme.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 16.03.25.
//

import SwiftUI

extension ShapeStyle where Color == Self {
    static var globalAccent: Color {
        Color(red: 0.67, green: 0.6, blue: 0.7)
    }
    
    static var foregroundColor: Color {
        Color(red: 0.37, green: 0.3, blue: 0.4)
    }
    
    static var darkBackground: Color {
        Color(red: 0.27, green: 0.2, blue: 0.3)
    }
}

extension Color {
    var rgb: [CGFloat] {
        guard let components = UIColor(self).cgColor.components else {return [0, 0, 0]}
        return Array(components)
    }
    
    init(rgb: [CGFloat]) {
        self.init(red: rgb[0], green: rgb[1], blue: rgb[2])
    }
}

@Observable
class colorManager: ObservableObject {
    var accentColor: Color {
        didSet {
            UserDefaults.standard.set(accentColor.rgb, forKey: "accentColor")
        }
    }
    var foregroundColor: Color {
        didSet {
            UserDefaults.standard.set(foregroundColor.rgb, forKey: "foregroundColor")
        }
    }
    var backgroundColor: Color {
        didSet {
            UserDefaults.standard.set(backgroundColor.rgb, forKey: "backgroundColor")
        }
    }
    
    var textColor: Color {
        didSet {
            UserDefaults.standard.set(textColor.rgb, forKey: "textColor")
        }
    }
    
    init() {
        accentColor = Color(rgb: UserDefaults.standard.array(forKey: "accentColor") as? [CGFloat] ?? Color.globalAccent.rgb)
        foregroundColor = Color(rgb: UserDefaults.standard.array(forKey: "foregroundColor") as? [CGFloat] ?? Color.foregroundColor.rgb)
        backgroundColor = Color(rgb: UserDefaults.standard.array(forKey: "backgroundColor") as? [CGFloat] ?? Color.darkBackground.rgb)
        textColor = Color(rgb: UserDefaults.standard.array(forKey: "textColor") as? [CGFloat] ?? Color.white.rgb)
    }
}
