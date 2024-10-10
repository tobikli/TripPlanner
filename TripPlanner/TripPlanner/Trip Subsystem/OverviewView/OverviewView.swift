//
//  OverviewView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//
import SwiftUI
import SwiftData

struct OverviewView: View {
    @ObservedObject var overviewViewModel: OverviewViewModel
    @State private var showingAddItemView = false

    var body: some View {
        NavigationView {
            Form {
                TripInformationSection(trip: overviewViewModel.trip)
                DatesSection(from: overviewViewModel.formattedTripDates().from,
                             till: overviewViewModel.formattedTripDates().till)
                WeatherSection(validWeather: overviewViewModel.validWeather,
                               location: overviewViewModel.trip.location,
                               weatherIcon: overviewViewModel.weatherIcon,
                               temperature: overviewViewModel.temperature)
                ComingUpSection()
                
                Button(action: {
                    showingAddItemView.toggle()
                }) {
                    Label("Edit Trip", systemImage: "pencil")
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
            trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100)))
}
