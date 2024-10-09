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

    var body: some View {
        Form {
            Section(header: Text("Trip Information")) {
                Text("Trip Name: \(overviewViewModel.trip.name)")
                Text("Location: \(overviewViewModel.trip.location)")
            }
            
            Section(header: Text("Dates")) {
                HStack {
                    Text("From:")
                    Spacer()
                    Text(overviewViewModel.formattedTripDates().from)
                }
                
                HStack {
                    Text("Till:")
                    Spacer()
                    Text(overviewViewModel.formattedTripDates().till)
                }
            }
            Section(header: Text("Weather")) {
                VStack {
                    if overviewViewModel.validWeather {
                        Spacer()
                        Text("The weather currently in \(overviewViewModel.trip.location)")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        HStack{
                            Image(systemName: overviewViewModel.weatherIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .padding()
                            Text(overviewViewModel.temperature)
                                .font(.system(size: 40))
                            
                        }
                    } else {
                        Text("Could not fetch weather")
                            .foregroundStyle(.red)
                    }
                }
            }
            Section(header: Text("Coming Up")){
                Text("TODO")
            }
        }
        .navigationTitle(overviewViewModel.trip.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}





#Preview {
    OverviewView(overviewViewModel: OverviewViewModel(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100)))
}
