//
//  AddEventViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import Foundation

import SwiftUI
import SwiftData

///View Model for the AddEventView
@Observable class AddEventViewModel {
    var modelContext: ModelContext
    
    var name: String = ""
    var location: String = ""
    var from = Date()
    var until = Date()
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
                from: from,
                until: until,
                cost: cost,
                category: category,
                flightNumber: flightNumber)
            modelContext.insert(newEvent)
            trip.events.append(newEvent)
        }
    }
}
