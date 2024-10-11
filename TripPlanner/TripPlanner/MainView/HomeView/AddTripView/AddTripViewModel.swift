//
//  AddTripViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import SwiftData

@Observable class AddTripViewModel {
    var modelContext: ModelContext
    
    init(modelContext : ModelContext) {
        self.modelContext = modelContext
    }
    
    var name: String = "My Awesome Trip"
    var location: String = ""
    var from = Date()
    var till = Date()
    var budget: Double = 0.0
    
    func addItem() {
        withAnimation {
            let newTrip = Trip(name: name, location: location, from: from, till: till, budget: budget)
            modelContext.insert(newTrip)
        }
    }
}
