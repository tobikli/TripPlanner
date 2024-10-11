//
//  TripInformationView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI

struct TripInformationSection: View {
    @State var trip: Trip
    @Binding var editMode: Bool
    
    var body: some View {
        Section(header: Text("Trip Information")) {
            if editMode {
                ZStack(alignment: .trailing) {
                    TextField("Trip Name:", text: $trip.name)
                    Image(systemName: "pencil")
                        .background(.blue)
                }
                ZStack(alignment: .trailing) {
                    TextField("Location:", text: $trip.location)
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
            } else {
                Text("Trip Name: \(trip.name)")
                Text("Location: \(trip.location)")
            }
        }
    }
}
