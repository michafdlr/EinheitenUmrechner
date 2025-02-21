//
//  Categories.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 17.02.25.
//

import Foundation
import SwiftUI

struct Category: Identifiable {
    let id = UUID().uuidString
    let view: () -> AnyView
    let text: LocalizedStringResource
    let imageName: String
    
    init<V: View>(view: @escaping () -> V, text: LocalizedStringResource, imageName: String) {
            self.view = { AnyView(view()) }  // Wrap view in AnyView
            self.text = text
            self.imageName = imageName
        }
}

let allCategories = [
    Category(view: {AngleView()}, text: "Angle", imageName: "angle"),
    Category(view: {LengthView()}, text: "Length", imageName: "ruler.fill"),
    Category(view: {AreaView()}, text: "Area", imageName: "rectangle.inset.fill"),
    Category(view: {VolumeView()}, text: "Volume", imageName: "cube.fill"),
    Category(view: {MassView()}, text: "Mass", imageName: "scalemass.fill"),
    Category(view: {TemperatureView()}, text: "Temperature", imageName: "thermometer.sun.circle.fill"),
    Category(view: {DurationView()}, text: "Time", imageName: "clock.fill"),
    Category(view: {CurrencyView()}, text: "Currency", imageName: "eurosign.circle.fill"),
    Category(view: {ElectricCurrentView()}, text: "Electric Current", imageName: "bolt.horizontal.circle.fill"),
    Category(view: {AccelerationView()}, text: "Acceleration", imageName: "pedal.accelerator.fill"),
    Category(view: {EnergyView()}, text: "Energy", imageName: "fork.knife.circle.fill"),
    Category(view: {ElectricChargeView()}, text: "Electric Charge", imageName: "plusminus.circle.fill"),
    Category(view: {FrequencyView()}, text: "Frequency", imageName: "waveform.path.ecg.magnifyingglass"),
    Category(view: {FuelEfficiencyView()}, text: "Fuel Efficiency", imageName: "fuelpump.circle.fill"),
    Category(view: {ElectricResistanceView()}, text: "Electric Resistance", imageName: "waveform.path.ecg.text"),
    Category(view: {PressureView()}, text: "Pressure", imageName: "rectangle.compress.vertical"),
    Category(view: {PowerView()}, text: "Power", imageName: "bolt.circle.fill"),
    Category(view: {SpeedView()}, text: "Speed", imageName: "gauge.with.dots.needle.67percent"),
    Category(view: {StorageView()}, text: "Information Storage", imageName: "01.circle.fill"),
    Category(view: {ElectricPotentialView()}, text: "Electric Potential", imageName: "bolt.ring.closed"),
]
