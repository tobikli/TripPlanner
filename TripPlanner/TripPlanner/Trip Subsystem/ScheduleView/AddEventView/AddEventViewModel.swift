//
//  AddEventViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import Foundation

import SwiftUI
import SwiftData

@Observable class AddEventViewModel {
    var modelContext: ModelContext
    
    var name: String = ""
    var location: String = ""
    var date = Date()
    var cost: Double = 0.0
    var category: String = "Flight"
    var flightNumber: String = ""
    
    var trip: Trip
    
    init(modelContext: ModelContext, trip: Trip) {
        self.modelContext = modelContext
        self.trip = trip
    }
    
    /**
        Adds the newly created Event to the viewModel and to the trip
     */
    func addEvent() {
        withAnimation {
            let newEvent = Event(
                name: name,
                location: location,
                date: date,
                cost: cost,
                category: category,
                flightNumber: flightNumber)
            modelContext.insert(newEvent)
            trip.events.append(newEvent)
        }
    }
}
