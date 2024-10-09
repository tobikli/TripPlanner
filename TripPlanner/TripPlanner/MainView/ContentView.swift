//
//  ContentView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showingAddItemView = false
    let calendar = Calendar.current

    var body: some View {
        NavigationView {
            VStack {
                if trips.isEmpty {
                    Spacer()
                    Text("No Trips yet")
                        .font(.headline)
                        .fontWeight(.light)
                    .padding(.top)}
                List {
                    Section(header: Text("Current Trips")) {
                        ForEach(trips) { trip in
                            if trip.from <= Date() && (calendar.isDate(trip.till, inSameDayAs: Date()) || trip.till > Date()) {
                                NavigationLink {
                                    TripView(trip: trip)
                                } label: {
                                    TripBox(trip: trip)
                                }
                            }
                        } .onDelete(perform: deleteItems)
                    }
                    Section(header: Text("Future Trips")) {
                        ForEach(trips) { trip in
                            if trip.from > Date() {
                                NavigationLink {
                                    TripView(trip: trip)
                                } label: {
                                    TripBox(trip: trip)
                                }
                            }
                        } .onDelete(perform: deleteItems)
                    }
                    Section(header: Text("Past Trips")) {
                        ForEach(trips) { trip in
                            if trip.till < Date() && !calendar.isDate(trip.till, inSameDayAs: Date())  {
                                NavigationLink {
                                    TripView(trip: trip)
                                } label: {
                                    TripBox(trip: trip)
                                }
                            }
                        } .onDelete(perform: deleteItems)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: {
                            showingAddItemView.toggle()
                        }
                        ) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle(Text("TripPlanner"))
                .sheet(isPresented: $showingAddItemView) {
                                    AddItemView()
                                }
                .listStyle(.grouped)

            }
        }
    }

    struct AddItemView: View {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.modelContext) private var modelContext

        @State private var name: String = "My Awesome Trip"
        @State private var location: String = ""
        @State private var from: Date = Date()
        @State private var till: Date = Date()
        @State private var budget: Double = 0.0
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Information")) {
                        TextField("Trip Name", text: $name)
                        TextField("Location", text: $location)
                    }
                    Section(header: Text("Time")) {
                        DatePicker("From", selection: $from, displayedComponents: .date)
                        DatePicker("Till", selection: $till, displayedComponents: .date)
                    }
                    Section(header: Text("Budget")) {
                        TextField("Initial Budget", value: $budget, format: .currency(code: "EUR")).keyboardType(.decimalPad)
                    }
                }
                .navigationTitle("Create New Trip")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Create") {
                            addItem()
                            dismiss()
                        }
                    }
                }
            }
        }

    ///Add newly created Trip to modelContext and DB
    private func addItem() {
            withAnimation {
                let newTrip = Trip(name: name, location: location, from: from, till: till, budget: budget)
                modelContext.insert(newTrip)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}

struct TripBox: View {
    var trip: Trip
    var body: some View {
        HStack {
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
                HStack(alignment: .center) {
                    Text(trip.from, format: Date.FormatStyle(date: .abbreviated, time: .omitted)).fontWeight(.light).font(.system(size: 12))
                    Text("-")
                    Text(trip.till, format: Date.FormatStyle(date: .abbreviated, time: .omitted)).fontWeight(.light).font(.system(size: 12))
                }
        }
    }
}
