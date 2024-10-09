//
//  TripView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData
import MapKit
import Combine

struct TripView: View {
    var trip: Trip
    
    var body: some View {
        TabView{
            OverviewView(trip: trip)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Overview")
                }
            ScheduleView(trip: trip)
                .tabItem {
                    Image(systemName: "timelapse")
                    Text("Schedule")
                }
            BudgetView(trip: trip)
                .tabItem {
                    Image(systemName: "dollarsign")
                    Text("Budget")
                }
        }
    }
}


#Preview {
    TripView(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date()))
}


struct OverviewView: View {
    var trip: Trip
    
    var body: some View {
        Form {
            Section(header: Text("Trip Information")) {
                Text("Trip Name: \(trip.name)")
                Text("Location: \(trip.location)")
            }
            
            Section(header: Text("Dates")) {
                HStack {
                    Text("From:")
                    Spacer()
                    Text(trip.from, format: Date.FormatStyle(date: .abbreviated, time: .omitted))
                }
                
                HStack {
                    Text("Till:")
                    Spacer()
                    Text(trip.till, format: Date.FormatStyle(date: .abbreviated, time: .omitted))
                }
            }
        }
        .navigationTitle(trip.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScheduleView: View {
    var trip: Trip
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                }) {
                    Text("Create Event")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .padding()
                List(trip.events, id: \.self){event in
                    Text(event.name)
                    
                }
                .navigationTitle("Upcoming Events")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BudgetView: View {
    var trip: Trip
    
    var body: some View {
        List {
            Text("Budget Placeholder")
        }
        .navigationTitle("Budget")
        .navigationBarTitleDisplayMode(.inline)
    }
}


