//
//  TripView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData

struct TripView: View {
    var trip: Trip
    @State private var tab = 0
    
    var body: some View {
        NavigationView {
            VStack {
                switch tab {
                case 0:
                    OverviewView(trip: trip)
                case 1:
                    ScheduleView(trip: trip)
                case 2:
                    BudgetView(trip: trip)
                default:
                    OverviewView(trip: trip)
                }
                Spacer()
                TabView(selection: $tab) {
                    Text("")
                        .tabItem {
                            Label("Overview", systemImage: "airplane.departure")
                        }
                        .tag(0)
                    
                    Text("")
                        .tabItem {
                            Label("Schedule", systemImage: "list.bullet")
                        }
                        .tag(1)
                    
                    // Tab 3 - Budget
                    Text("")
                        .tabItem {
                            Label("Budget", systemImage: "dollarsign.circle")
                        }
                        .tag(2)
                }
                .frame(height: 50)
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
