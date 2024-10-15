//
//  TripSectionViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import SwiftData

///View Model for the TripSectionView
@Observable class TripSectionViewModel {
    let type: String
    let calendar = Calendar.current
    var modelContext: ModelContext
    var trips: [Trip] = []

    init(trips: [Trip], type: String, modelContext: ModelContext) {
        self.trips = trips
        self.type = type
        self.modelContext = modelContext
    }
    /**
     Fetches the already stored trips from the database and returns them as an array
         params: none
         returns: returns array of trips from the database
         throws: none
     */
    func fetchTrips() -> [Trip] {
        let fetchDescriptor = FetchDescriptor<Trip>()
        do {
            let trips = try modelContext.fetch(fetchDescriptor)
            return trips
        } catch {
            print("Error fetching trips: \(error)")
            return []
        }
    }

    /**
     Filters the trips to their fitting category, if they are current, past or future
         params: none
         returns: returns array of trips filtered by Date
         throws: none
     */
    func getTrips() -> [Trip] {
        switch type {
        case "Current":
            return fetchTrips().filter { trip in
                calendar.isDate(trip.till, inSameDayAs: Date()) || (trip.till > Date() && trip.from <= Date())
            }
        case "Future":
            return fetchTrips().filter { trip in trip.from > Date() }
        case "Past":
            return fetchTrips().filter { trip in
                trip.till < Date() && !calendar.isDate(trip.till, inSameDayAs: Date())
            }
        default:
            return fetchTrips()
        }
    }

    /**
     Deletes the trip from the modelContext with Animation
         params: offset of where the trip should be deleted from the modelContext
         returns: none
         throws: none
     */
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}
