//
//  TripInformationView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI

struct TripInformationSection: View {
    var trip: Trip
    
    var body: some View {
        Section(header: Text("Trip Information")) {
            Text("Trip Name: \(trip.name)")
            Text("Location: \(trip.location)")
        }
    }
}
