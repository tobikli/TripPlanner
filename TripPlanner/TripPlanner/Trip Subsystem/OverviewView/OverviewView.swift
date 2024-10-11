//
//  OverviewView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//
import SwiftUI
import SwiftData
import MapKit

struct OverviewView: View {
    @State var overviewViewModel: OverviewViewModel
    @State private var editMode = false

    var body: some View {
        NavigationView {
            Form {
                TripInformationSection(trip: overviewViewModel.trip, editMode: $editMode)
                DatesSection(trip: overviewViewModel.trip, editMode: $editMode)
                WeatherSection(validWeather: overviewViewModel.validWeather,
                               location: overviewViewModel.trip.location,
                               weatherIcon: overviewViewModel.weatherIcon,
                               temperature: overviewViewModel.temperature)
                ComingUpSection(viewModel: overviewViewModel)
                
                Button(action: {
                    editMode.toggle()
                }) {
                    editMode ? Label("Done", systemImage: "checkmark") : Label("Edit Trip", systemImage: "pencil")
                }
            }
            .navigationTitle(overviewViewModel.trip.name)
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    OverviewView(
        overviewViewModel: OverviewViewModel(
            trip: Trip(name: "Cool Trip", location: "Dortmund", from: Date(), till: Date(), budget: 100)))
}
