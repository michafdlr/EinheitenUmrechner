//
//  Categories.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 17.02.25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Favorite: Identifiable {
    var id = UUID()
    var unitSymbol: String
    var categoryName: CategoryName
    
    init(name: Dimension, categoryName: CategoryName) {
        self.unitSymbol = name.symbol
        self.categoryName = categoryName
    }
    
//    var unit: Dimension? {
//        UnitFactory.unit(from: unitSymbol)
//    }
}

@Model
class CategoryName {
    var name: String
    var favorites: [Favorite]
    
    init(name: String, favorites: [Favorite] = [Favorite]()) {
        self.name = name
        self.favorites = favorites
    }
}

extension CategoryName {
    static var allCategoryNames: [CategoryName] {
        [
            .init(name: "Angle"),
            .init(name: "Area"),
            .init(name: "Length"),
            .init(name: "Volume"),
            .init(name: "Mass"),
            .init(name: "Temperature"),
            .init(name: "Time"),
            .init(name: "Electric Current"),
            .init(name: "Acceleration"),
            .init(name: "Energy"),
            .init(name: "Electric Charge"),
            .init(name: "Frequency"),
            .init(name: "Fuel Efficiency"),
            .init(name: "Electric Resistance"),
            .init(name: "Pressure"),
            .init(name: "Power"),
            .init(name: "Speed"),
            .init(name: "Information Storage"),
            .init(name: "Electric Potential"),
        ]
    }
}

actor CategoriesContainer {
    @MainActor
    static func createCategories(shouldCreateDefault: inout Bool) -> ModelContainer? {
        let schema = Schema([CategoryName.self, Favorite.self])
        let config = ModelConfiguration()
        do {
            let container = try ModelContainer(for: schema, configurations: config)
            if shouldCreateDefault {
                CategoryName.allCategoryNames.forEach { container.mainContext.insert($0) }
                shouldCreateDefault = false
            }
            return container
        } catch {
            print("Failed to instantiate model container with error: \(error)")
            return nil
        }
    }
}

struct Category: Identifiable {
    var id = UUID().uuidString
    var view: () -> AnyView
    var title: LocalizedStringResource
    var imageName: String

    init<V: View>(
        view: @escaping () -> V,
        title: LocalizedStringResource,
        imageName: String
    ) {
        self.view = { AnyView(view()) }  // Wrap view in AnyView
        self.title = title
        self.imageName = imageName
    }
}

let allCategories = [
    Category(view: { AngleView() }, title: "Angle", imageName: "angle"),
    Category(view: { LengthView() }, title: "Length", imageName: "ruler.fill"),
    Category(
        view: { AreaView() }, title: "Area", imageName: "rectangle.inset.fill"),
    Category(view: { VolumeView() }, title: "Volume", imageName: "cube.fill"),
    Category(view: { MassView() }, title: "Mass", imageName: "scalemass.fill"),
    Category(
        view: { TemperatureView() }, title: "Temperature",
        imageName: "thermometer.sun.circle.fill"),
    Category(view: { DurationView() }, title: "Time", imageName: "clock.fill"),
    Category(
        view: { CurrencyView() }, title: "Currency",
        imageName: "eurosign.circle.fill"),
    Category(
        view: { ElectricCurrentView() }, title: "Electric Current",
        imageName: "bolt.horizontal.circle.fill"),
    Category(
        view: { AccelerationView() }, title: "Acceleration",
        imageName: "pedal.accelerator.fill"),
    Category(
        view: { EnergyView() }, title: "Energy",
        imageName: "fork.knife.circle.fill"),
    Category(
        view: { ElectricChargeView() }, title: "Electric Charge",
        imageName: "plusminus.circle.fill"),
    Category(
        view: { FrequencyView() }, title: "Frequency",
        imageName: "waveform.path.ecg.magnifyingglass"),
    Category(
        view: { FuelEfficiencyView() }, title: "Fuel Efficiency",
        imageName: "fuelpump.circle.fill"),
    Category(
        view: { ElectricResistanceView() }, title: "Electric Resistance",
        imageName: "waveform.path.ecg.text"),
    Category(
        view: { PressureView() }, title: "Pressure",
        imageName: "rectangle.compress.vertical"),
    Category(
        view: { PowerView() }, title: "Power", imageName: "bolt.circle.fill"),
    Category(
        view: { SpeedView() }, title: "Speed",
        imageName: "gauge.with.dots.needle.67percent"),
    Category(
        view: { StorageView() }, title: "Information Storage",
        imageName: "01.circle.fill"),
    Category(
        view: { ElectricPotentialView() }, title: "Electric Potential",
        imageName: "bolt.ring.closed"),
]
