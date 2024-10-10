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

struct TripInformationSection: View {
    var trip: Trip
    
    var body: some View {
        Section(header: Text("Trip Information")) {
            Text("Trip Name: \(trip.name)")
            Text("Location: \(trip.location)")
        }
    }
}

struct DatesSection: View {
    var from: String
    var till: String
    
    var body: some View {
        Section(header: Text("Dates")) {
            HStack {
                Text("From:")
                Spacer()
                Text(from)
            }
            
            HStack {
                Text("Till:")
                Spacer()
                Text(till)
            }
        }
    }
}

struct WeatherSection: View {
    var validWeather: Bool
    var location: String
    var weatherIcon: String
    var temperature: String
    
    var body: some View {
        Section(header: Text("Weather")) {
            VStack {
                if validWeather {
                    Spacer()
                    Text("The weather currently in \(location)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    HStack {
                        Image(systemName: weatherIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .padding()
                        Text(temperature)
                            .font(.system(size: 40))
                    }
                } else {
                    Text("Could not fetch weather")
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

struct ComingUpSection: View {
    var body: some View {
        Section(header: Text("Coming Up")) {
            Text("TODO")
        }
    }
}

#Preview {
    OverviewView(
        overviewViewModel: OverviewViewModel(
            trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100)))
}
