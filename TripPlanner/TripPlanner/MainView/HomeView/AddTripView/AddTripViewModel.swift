//
//  AddTripViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import SwiftData

///View Model for the AddTrip View
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

    /**
     Adds the newly created Trip into the modelContext with an animation
         params: none
         returns: none
         throws: none
     */
    func addTrip() {
        withAnimation {
            let newTrip = Trip(name: name, location: location, from: from, till: till, budget: budget)
            modelContext.insert(newTrip)
        }
    }
}
