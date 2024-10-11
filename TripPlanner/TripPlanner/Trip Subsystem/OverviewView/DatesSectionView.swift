//
//  DataSectionView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI


struct DatesSection: View {
    @State var trip: Trip
    @Binding var editMode: Bool
    
    var body: some View {
        Section(header: Text("Dates")) {
            if editMode {
                DatePicker("From", selection: $trip.from, displayedComponents: .date)
                DatePicker("Until", selection: $trip.till, displayedComponents: .date)
            } else {
                HStack {
                    Text("From:")
                    Spacer()
                    Text(trip.from.formatted())
                }
                
                HStack {
                    Text("Until:")
                    Spacer()
                    Text(trip.till.formatted())
                }
            }
        }
    }
}
