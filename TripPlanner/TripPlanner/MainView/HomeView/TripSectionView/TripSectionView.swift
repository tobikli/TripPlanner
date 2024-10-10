//
//  TripSection.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import Foundation
import SwiftUI


struct  TripSection: View {
    var trips: [Trip]
    let calendar = Calendar.current
    let deleteAction: (IndexSet) -> Void
    
    var body: some View {
        Section(header: Text("Current Trips")) {
            ForEach(trips) { trip in
                if trip.from <= Date() &&
                    (calendar.isDate(trip.till, inSameDayAs: Date()) || trip.till > Date()) {
                    NavigationLink {
                        TripView(trip: trip)
                    } label: {
                        TripBox(trip: trip)
                    }
                }
            }
            .onDelete(perform: deleteAction)
        }
    }
}
