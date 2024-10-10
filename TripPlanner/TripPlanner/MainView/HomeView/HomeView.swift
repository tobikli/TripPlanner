//
//  ContentView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showingAddItemView = false
    
    var body: some View {
            NavigationView {
                VStack {
                    if trips.isEmpty {
                        Spacer()
                        Text("No Trips yet")
                            .font(.headline)
                            .fontWeight(.light)
                            .padding(.top)
                    }
                    List {
                        CurrentTripsSection(trips: trips, deleteAction: deleteItems)
                        FutureTripsSection(trips: trips, deleteAction: deleteItems)
                        PastTripsSection(trips: trips, deleteAction: deleteItems)
                    }
                    .listStyle(.sidebar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: {
                                showingAddItemView.toggle()
                            }) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    .navigationTitle(Text("TripPlanner"))
                    .sheet(isPresented: $showingAddItemView) {
                        AddTripView(trips: trips)
                    }
                    .listStyle(.grouped)
                }
            }
        }

    

    
}

#Preview {
    HomeView()
        .modelContainer(for: Trip.self, inMemory: true)
}

struct CurrentTripsSection: View {
    var trips: [Trip]
    let calendar = Calendar.current
    let deleteAction: (IndexSet) -> Void
    
    var body: some View {
        Section(header: Text("Current Trips")) {
            ForEach(trips) { trip in
                if trip.from <= Date() &&
                    (calendar.isDate(trip.till, inSameDayAs: Date()) || trip.till > Date()) {
                    NavigationLink {
                        TripView(trip: trip)
                    } label: {
                        TripBox(trip: trip)
                    }
                }
            }
            .onDelete(perform: deleteAction)
        }
    }
}

struct FutureTripsSection: View {
    var trips: [Trip]
    let deleteAction: (IndexSet) -> Void
    
    var body: some View {
        Section(header: Text("Future Trips")) {
            ForEach(trips) { trip in
                if trip.from > Date() {
                    NavigationLink {
                        TripView(trip: trip)
                    } label: {
                        TripBox(trip: trip)
                    }
                }
            }
            .onDelete(perform: deleteAction)
        }
    }
}

struct PastTripsSection: View {
    var trips: [Trip]
    let calendar = Calendar.current
    let deleteAction: (IndexSet) -> Void
    
    var body: some View {
        Section(header: Text("Past Trips")) {
            ForEach(trips) { trip in
                if trip.till < Date() && !calendar.isDate(trip.till, inSameDayAs: Date()) {
                    NavigationLink {
                        TripView(trip: trip)
                    } label: {
                        TripBox(trip: trip)
                    }
                }
            }
            .onDelete(perform: deleteAction)
        }
    }
}

struct TripBox: View {
    var trip: Trip
    var body: some View {
        HStack {
            Image(systemName: "airplane")
            VStack(alignment: .leading) {
                Text(trip.name)
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Your trip to \(trip.location)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
            Spacer()
                   
                VStack(alignment: .center) {
                    Text(trip.from, format: Date.FormatStyle()
                        .day(.twoDigits)
                        .month(.abbreviated))
                    .fontWeight(.light)
                    .font(.system(size: 12))
                        .padding(.bottom, 2)
                    Text(trip.till, format: Date.FormatStyle()
                        .day(.twoDigits)
                        .month(.abbreviated))
                    .fontWeight(.light)
                    .font(.system(size: 12))
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.primary, lineWidth: 0.5)
                )
            Spacer()
                .frame(maxWidth: 20)
        }
    }
}
