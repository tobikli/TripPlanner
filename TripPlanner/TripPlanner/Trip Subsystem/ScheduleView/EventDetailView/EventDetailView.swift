//
//  EventDetailView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    var event: Event
    let mapView = MKMapView()
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Information")) {
                    Text("Type: \(event.category)")
                    Text("Name: \(event.name)")
                    Text("Location: \(event.location)")
                    Text("Date: \(event.date.formatted())")
                    Text("Cost: \(event.cost.formatted(.currency(code: "EUR")))")
                    if let fn = event.flightNumber {
                        Text("Flight Number: \(fn)")
                    }
                }
                Section(header: Text("Location")) {
                    Map()
                        .frame(height: 200)
                }
            }
            .navigationTitle(Text(event.name))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarItems(trailing: Button(action: {}, label: { Text("Edit") }))
    }
}
